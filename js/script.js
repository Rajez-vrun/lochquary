// ===== Smooth Scrolling ===== 
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// ===== Page Load Animation =====
window.addEventListener('load', () => {
    const sections = document.querySelectorAll('section');
    sections.forEach((section, index) => {
        section.style.opacity = '0';
        section.style.transform = 'translateY(20px)';
        section.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        
        setTimeout(() => {
            section.style.opacity = '1';
            section.style.transform = 'translateY(0)';
        }, index * 100);
    });
});

// ===== Newsletter Form Handler =====
function handleNewsletterSubmit(event) {
    event.preventDefault();
    
    const name = document.getElementById('name').value;
    const email = document.getElementById('email').value;
    
    // Simple validation
    if (name && email) {
        alert(`Thank you for subscribing, ${name}! Check your email at ${email} for a confirmation.`);
        event.target.reset();
    } else {
        alert('Please fill in all required fields.');
    }
}

// ===== Contact Form Handler =====
function handleContactSubmit(event) {
    event.preventDefault();
    
    const name = document.getElementById('contact-name').value;
    const email = document.getElementById('contact-email').value;
    const subject = document.getElementById('subject').value;
    
    // Simple validation
    if (name && email && subject) {
        alert(`Thank you for your message, ${name}! We'll get back to you at ${email} soon.`);
        event.target.reset();
    } else {
        alert('Please fill in all required fields.');
    }
}

// ===== Console Welcome Message =====
console.log('%c🏕️ Welcome to Loch Quarry Outdoor Center!', 'font-size: 20px; color: #3498db; font-weight: bold;');
console.log('%cYour destination for outdoor adventures', 'font-size: 14px; color: #2c3e50;');

// Position the tagline to start just below the end of the company name
console.log('✓ Loch Quarry site loaded - hero slideshow active');

// Removed dynamic tagline positioning because tagline is now positioned via CSS
// This keeps the layout stable and responsive; keep JS minimal.
