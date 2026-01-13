param(
    [int]$Port = 8000,
    [string]$Root = (Get-Location).Path
)

$listener = New-Object System.Net.HttpListener
$prefix = "http://localhost:$Port/"
$listener.Prefixes.Add($prefix)
try {
    $listener.Start()
} catch {
    Write-Error "Failed to start listener on port $Port. Maybe port in use or missing permissions."
    exit 1
}
Write-Host "Serving files from $Root at http://localhost:$Port/ (Ctrl+C to stop)"

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response
    $localPath = $request.Url.LocalPath.TrimStart('/')
    if ([string]::IsNullOrEmpty($localPath)) { $localPath = 'index.html' }
    $file = Join-Path $Root $localPath
    if (-not (Test-Path $file)) {
        $response.StatusCode = 404
        $bytes = [System.Text.Encoding]::UTF8.GetBytes("404 - Not Found")
        $response.ContentLength64 = $bytes.Length
        $response.OutputStream.Write($bytes, 0, $bytes.Length)
        $response.OutputStream.Close()
        continue
    }
    $ext = [IO.Path]::GetExtension($file).ToLower()
    switch ($ext) {
        ".html" { $contentType = "text/html" }
        ".htm"  { $contentType = "text/html" }
        ".css"  { $contentType = "text/css" }
        ".js"   { $contentType = "application/javascript" }
        ".json" { $contentType = "application/json" }
        ".png"  { $contentType = "image/png" }
        ".jpg"  { $contentType = "image/jpeg" }
        ".jpeg" { $contentType = "image/jpeg" }
        ".gif"  { $contentType = "image/gif" }
        ".svg"  { $contentType = "image/svg+xml" }
        default  { $contentType = "application/octet-stream" }
    }
    $bytes = [System.IO.File]::ReadAllBytes($file)
    $response.ContentType = $contentType
    $response.ContentLength64 = $bytes.Length
    $response.OutputStream.Write($bytes, 0, $bytes.Length)
    $response.OutputStream.Close()
}
