(() => {
    const grids = document.querySelectorAll('.issues-grid[data-repo]');
    if (!grids.length) return;

    const loadScript = (src) => {
        const el = document.createElement('script');
        el.src = src;
        const ready = new Promise(resolve => { el.onload = resolve; el.onerror = resolve; });
        document.head.appendChild(el);
        return ready;
    };

    const markedReady = loadScript('https://cdn.jsdelivr.net/npm/marked/marked.min.js');
    const hljsReady = loadScript('https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js');

    const hljsStyle = document.createElement('style');
    hljsStyle.textContent = `
        .hljs { background: var(--color-surface); color: var(--color-text); }
        .hljs-comment, .hljs-quote { color: var(--color-muted); font-style: italic; }
        .hljs-keyword, .hljs-selector-tag, .hljs-deletion { color: var(--color-red); }
        .hljs-string, .hljs-addition, .hljs-meta .hljs-string { color: var(--color-yellow); }
        .hljs-number, .hljs-literal, .hljs-regexp { color: var(--color-purple); }
        .hljs-built_in, .hljs-class .hljs-title, .hljs-title.class_ { color: var(--color-accent); }
        .hljs-title, .hljs-title.function_ { color: var(--color-green); }
        .hljs-type, .hljs-meta { color: var(--color-orange); }
        .hljs-attr, .hljs-attribute, .hljs-variable, .hljs-template-variable { color: var(--color-accent); }
        .hljs-symbol, .hljs-bullet { color: var(--color-red); }
        .hljs-emphasis { font-style: italic; }
        .hljs-strong { font-weight: bold; }
    `;
    document.head.appendChild(hljsStyle);

    const renderMarkdown = (text, container) => {
        container.innerHTML = typeof marked !== 'undefined'
            ? marked.parse(text)
            : `<p>${text}</p>`;
        if (typeof hljs !== 'undefined')
            container.querySelectorAll('pre code').forEach(el => hljs.highlightElement(el));
    };

    // Modal
    const modal = document.createElement('div');
    modal.className = 'fixed inset-0 z-[200] flex items-center justify-center p-4 hidden';
    modal.innerHTML = `
        <div id="modal-backdrop" class="absolute inset-0 bg-black/60 backdrop-blur-sm"></div>
        <div class="relative bg-background border border-text/10 rounded-2xl shadow-2xl w-full max-w-3xl max-h-[85vh] flex flex-col overflow-hidden">
            <div class="flex items-start justify-between p-6 border-b border-text/10 gap-4">
                <div class="min-w-0">
                    <div id="modal-badges" class="flex flex-wrap gap-2 mb-3"></div>
                    <h2 id="modal-title" class="text-2xl font-extrabold text-text"></h2>
                </div>
                <div class="flex items-center gap-3 shrink-0 mt-1">
                    <a id="modal-link" href="#" target="_blank" class="text-xs font-mono text-muted hover:text-accent underline underline-offset-4 transition-colors">View on GitHub</a>
                    <button id="modal-close" class="text-muted hover:text-text transition-colors text-lg leading-none cursor-pointer">✕</button>
                </div>
            </div>
            <div id="modal-body" class="overflow-y-auto p-6 markdown-body text-muted text-sm leading-relaxed"></div>
        </div>
    `;
    document.body.appendChild(modal);

    const closeModal = () => modal.classList.add('hidden');
    document.getElementById('modal-close').addEventListener('click', closeModal);
    document.getElementById('modal-backdrop').addEventListener('click', closeModal);
    document.addEventListener('keydown', e => { if (e.key === 'Escape') closeModal(); });

    const labelColor = (name) => {
        if (name === 'blocked') return 'text-red-400 border-red-400/20 bg-red-400/10';
        if (name === 'breaking') return 'text-orange-400 border-orange-400/20 bg-orange-400/10';
        if (name === 'good first issue') return 'text-green border-green/20 bg-green/10';
        return 'text-accent border-accent/20 bg-accent/10';
    };

    const badgesHtml = (labels) => labels.map(l =>
        `<span class="text-[10px] font-bold uppercase tracking-wider px-2 py-1 rounded border ${labelColor(l.name)}">${l.name}</span>`
    ).join('');

    const openModal = (issue) => {
        document.getElementById('modal-title').textContent = issue.title;
        document.getElementById('modal-badges').innerHTML = badgesHtml(issue.labels);
        document.getElementById('modal-link').href = issue.html_url;
        renderMarkdown(issue.body || '*No description provided.*', document.getElementById('modal-body'));
        modal.classList.remove('hidden');
    };

    const renderCard = (issue) => {
        const body = issue.body || '';
        const truncated = body.length > 240 ? body.slice(0, 240) + '…' : body;

        const card = document.createElement('div');
        card.className = 'flex flex-col p-6 rounded-xl border border-text/10 bg-surface/30 hover:bg-surface hover:border-text/20 hover:shadow-md transition-all duration-300 group cursor-pointer';

        const preview = document.createElement('div');
        preview.className = 'markdown-body text-muted text-sm leading-relaxed';

        card.innerHTML = `
            <div class="flex flex-wrap gap-2 mb-4">${badgesHtml(issue.labels)}</div>
            <h4 class="text-lg font-bold text-text group-hover:text-accent transition-colors mb-2">${issue.title}</h4>
        `;
        renderMarkdown(truncated, preview);
        card.appendChild(preview);

        card.addEventListener('click', () => openModal(issue));
        return card;
    };

    const CACHE_TTL = 60 * 60 * 1000; // 1 hour

    const cachedFetch = (url, key) => {
        try {
            const cached = localStorage.getItem(key);
            if (cached) {
                const { data, ts } = JSON.parse(cached);
                if (Date.now() - ts < CACHE_TTL) return Promise.resolve(data);
            }
        } catch (_) {}

        return fetch(url)
            .then(r => r.json())
            .then(data => {
                try { localStorage.setItem(key, JSON.stringify({ data, ts: Date.now() })); } catch (_) {}
                return data;
            });
    };

    grids.forEach(grid => {
        const repo = grid.dataset.repo;
        grid.innerHTML = '<p class="text-muted text-sm col-span-2">Loading...</p>';

        const descEl = document.querySelector(`[data-repo-desc="${repo}"]`);

        Promise.all([
            cachedFetch(`https://api.github.com/repos/voxell-tech/${repo}`, `gh-repo-${repo}`),
            cachedFetch(`https://api.github.com/repos/voxell-tech/${repo}/issues?state=open&per_page=50`, `gh-issues-${repo}`),
            markedReady,
            hljsReady,
        ]).then(([repoInfo, issues]) => {
            if (descEl) descEl.textContent = repoInfo.description || '';

            if (!Array.isArray(issues)) {
                grid.innerHTML = '<p class="text-muted text-sm col-span-2">Failed to load issues.</p>';
                return;
            }

            issues = issues.filter(i => !i.pull_request);
            if (!issues.length) {
                grid.innerHTML = '<p class="text-muted text-sm col-span-2">No open issues.</p>';
                return;
            }
            grid.innerHTML = '';
            issues.forEach(issue => grid.appendChild(renderCard(issue)));
        }).catch(() => {
            grid.innerHTML = '<p class="text-muted text-sm col-span-2">Failed to load issues.</p>';
        });
    });
})();
