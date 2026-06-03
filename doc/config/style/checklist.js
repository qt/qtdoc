/* checklist.js
 * Initialiser for the QDoc \checklist … \endchecklist macro set.
 * For each .cl-section on the page:
 *   1. Injects a checkbox <input> and wraps content in a <label> for each <li>.
 *   2. Drives the per-section progress bar and percentage on checkbox change.
 * Loaded via HTML.headerscripts (defer).
 */
document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.cl-section').forEach(function (section) {
        var bar   = section.querySelector('.cl-progress-fill');
        var pct   = section.querySelector('.cl-percent');

        /* ── Inject checkbox into each <li> ─────────────────────────────── */
        section.querySelectorAll('li').forEach(function (li) {
            var lbl = document.createElement('label');
            lbl.className = 'cl-item-label';

            var cb = document.createElement('input');
            cb.type      = 'checkbox';
            cb.className = 'cl-checkbox';

            var span = document.createElement('span');
            while (li.firstChild) span.appendChild(li.firstChild);

            lbl.appendChild(cb);
            lbl.appendChild(span);
            li.appendChild(lbl);
        });

        /* ── Progress bar ────────────────────────────────────────────────── */
        var checkboxes = Array.from(section.querySelectorAll('.cl-checkbox'));
        var n          = checkboxes.length;
        if (!bar || !pct || n === 0) return;

        function update() {
            var checked = checkboxes.filter(function (cb) { return cb.checked; }).length;
            var p       = Math.round(checked / n * 100);
            bar.style.width   = p + '%';
            pct.textContent   = p + '% complete';
        }

        checkboxes.forEach(function (cb) { cb.addEventListener('change', update); });
        update();
    });
});
