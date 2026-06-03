/* tasklist.js
 * Initialiser for the \tasklist … \endtasklist macro set.
 * For each guide on the page:
 *   - Injects Previous / Next Step nav into every panel based on step order.
 *   - Drives the progress bar on radio change events.
 * Loaded via HTML.headerscripts (defer) — no inline script needed in the macros.
 */
document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.qs-guide').forEach(function (guide) {
        var inputs = Array.from(guide.querySelectorAll('input.qs-input'));
        var bar    = guide.querySelector('.qs-progress-fill');
        var n      = inputs.length;
        if (n < 1) return;

        /* ── Inject nav footer into each panel ──────────────────────────── */
        inputs.forEach(function (input, i) {
            var panel = guide.querySelector('.qs-panel.' + input.id);
            if (!panel) return;

            var footer = document.createElement('div');
            footer.className = 'qs-footer';

            var prev = document.createElement('label');
            prev.className = 'qs-btn qs-btn-prev' + (i === 0 ? ' qs-hidden' : '');
            prev.textContent = 'Previous';
            if (i > 0) prev.setAttribute('for', inputs[i - 1].id);

            var next = document.createElement('label');
            next.className = 'qs-btn qs-btn-next' + (i === n - 1 ? ' qs-hidden' : '');
            next.textContent = i === n - 1 ? 'Finish' : 'Next Step ›';
            if (i < n - 1) next.setAttribute('for', inputs[i + 1].id);

            footer.appendChild(prev);
            footer.appendChild(next);
            panel.appendChild(footer);
        });

        /* ── Progress bar ────────────────────────────────────────────────── */
        if (!bar || n < 2) return;

        function update() {
            for (var i = 0; i < n; i++) {
                if (inputs[i].checked) {
                    bar.style.width = (i / (n - 1) * 100) + '%';
                    return;
                }
            }
        }

        inputs.forEach(function (inp) { inp.addEventListener('change', update); });
        update();
    });
});
