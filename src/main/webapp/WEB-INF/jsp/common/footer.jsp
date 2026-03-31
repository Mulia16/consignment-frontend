<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Confirm Modal (shared) -->
<div class="modal fade" id="confirmModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content">
            <div class="modal-header border-0 pb-0">
                <h6 class="modal-title"><i class="fas fa-exclamation-triangle text-warning mr-2"></i>Confirmation</h6>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body text-center py-3">
                Are you sure?
            </div>
            <div class="modal-footer border-0 pt-0 justify-content-center">
                <button type="button" class="btn btn-sm btn-secondary px-4" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-sm btn-danger px-4 btn-confirm">Yes, Proceed</button>
            </div>
        </div>
    </div>
</div>

<!-- jQuery -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
<!-- Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!-- Bootstrap 4 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>

<!-- App JS (Sync loading) -->
<script src="/static/js/api-config.js"></script>
<script src="/static/js/api-client.js"></script>
<script src="/static/js/common.js"></script>
<script src="/static/js/auth.js"></script>

<!-- Initialize Config before any API actions -->
<script>
    if (typeof API_CONFIG !== 'undefined') {
        API_CONFIG.loadConfig().then(function() {
            // Signal to individual page JS that they can begin API actions
            var event = new Event('configLoaded');
            document.dispatchEvent(event);
            
            // Fallback for older pages
            if (window.initPage) window.initPage();
            else if (typeof loadData === 'function') {
                if (!Auth.requireAuth()) return; 
                loadData();
            }
        });
    }
</script>

</body>
</html>
