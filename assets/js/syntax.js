window.SyntaxHighlight = (() => {
    const monokaiPro = {
        name: 'monokai-pro',
        type: 'dark',
        colors: { 'editor.background': '#2d2a2e', 'editor.foreground': '#fcfcfa' },
        tokenColors: [
            { scope: ['comment', 'punctuation.definition.comment'],          settings: { foreground: '#939293', fontStyle: 'italic' } },
            { scope: ['string', 'string.quoted', 'string.template'],         settings: { foreground: '#ffd866' } },
            { scope: ['constant.numeric', 'constant.language'],              settings: { foreground: '#ab9df2' } },
            { scope: ['keyword', 'storage.type', 'storage.modifier'],        settings: { foreground: '#ff6188' } },
            { scope: ['entity.name.function', 'support.function'],           settings: { foreground: '#a9dc76' } },
            { scope: ['entity.name.type', 'entity.name.class',
                      'support.class', 'entity.other.inherited-class'],      settings: { foreground: '#78dce8' } },
            { scope: ['variable', 'variable.other'],                         settings: { foreground: '#fcfcfa' } },
            { scope: ['keyword.operator', 'entity.name.tag'],                settings: { foreground: '#ff6188' } },
            { scope: ['support.type', 'support.other.namespace'],            settings: { foreground: '#78dce8' } },
            { scope: ['constant.other.color', 'support.constant'],           settings: { foreground: '#ab9df2' } },
            { scope: 'invalid',                                              settings: { foreground: '#ff6188', fontStyle: 'underline' } },
        ],
    };

    // Dual-theme CSS: dark = monokai-pro, light = github-light
    const style = document.createElement('style');
    style.textContent = `
        .shiki { overflow-x: auto; }
        .shiki span { color: var(--shiki-dark); }
        .shiki { background: var(--shiki-dark-bg) !important; }
        [data-theme="light"] .shiki span { color: var(--shiki-light); }
        [data-theme="light"] .shiki { background: var(--shiki-light-bg) !important; }
    `;
    document.head.appendChild(style);

    let highlighter = null;
    const ready = import('https://esm.sh/shiki@1').then(({ createHighlighter }) =>
        createHighlighter({
            themes: [monokaiPro, 'github-light'],
            langs: ['typst', 'rust', 'toml', 'bash', 'sh', 'javascript', 'typescript', 'python', 'json', 'css', 'html', 'markdown'],
        })
    ).then(h => { highlighter = h; }).catch(() => {});

    const highlight = (container) => {
        if (!highlighter) return;
        container.querySelectorAll('pre code').forEach(el => {
            const lang = (el.className.match(/language-(\w+)/) || [])[1] || 'text';
            try {
                el.closest('pre').outerHTML = highlighter.codeToHtml(el.textContent, {
                    lang,
                    themes: { dark: 'monokai-pro', light: 'github-light' },
                    defaultColor: false,
                });
            } catch (_) {}
        });
    };

    const renderMarkdown = (text, container) => {
        container.innerHTML = typeof marked !== 'undefined'
            ? marked.parse(text)
            : `<p>${text}</p>`;
        highlight(container);
    };

    return { ready, renderMarkdown };
})();
