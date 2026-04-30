(() => {
    const pages = document.querySelectorAll('.roadmap-page');
    const tabs = document.querySelectorAll('.roadmap-tab');
    
    if (!pages.length) return; 

    const show = (targetId) => {
        pages.forEach(p => {
            p.style.display = p.id === targetId ? '' : 'none';
        });
        
        tabs.forEach(t => {
            t.style.color = t.getAttribute('href') === `#${targetId}` ? 'var(--color-accent)' : '';
        });
    };
    
    const activate = () => {
        const hashId = location.hash.slice(1);
        
        const isValid = Array.from(pages).some(p => p.id === hashId);
        
        show(isValid ? hashId : pages[0].id);
    };
    
    window.addEventListener('hashchange', activate);
    activate();
})();