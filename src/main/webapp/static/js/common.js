
const AppUtils = {
    showToast: function (message, type) {
        type = type || 'info';
        const bgClass = {
            'success': 'bg-success',
            'danger': 'bg-danger',
            'warning': 'bg-warning text-dark',
            'info': 'bg-info'
        }[type] || 'bg-info';

        const existing = document.querySelectorAll('.app-toast');
        existing.forEach(function (el) { el.remove(); });

        const toast = document.createElement('div');
        toast.className = 'app-toast ' + bgClass + ' text-white px-4 py-3 rounded shadow';
        toast.style.cssText = 'position:fixed;top:20px;right:20px;z-index:9999;min-width:300px;animation:slideIn 0.3s ease;';
        toast.innerHTML = '<div class="d-flex align-items-center justify-content-between">' +
            '<span>' + message + '</span>' +
            '<button type="button" class="close text-white ml-3" onclick="this.closest(\'.app-toast\').remove()">&times;</button>' +
            '</div>';
        document.body.appendChild(toast);

        setTimeout(function () {
            if (toast.parentNode) {
                toast.style.animation = 'slideOut 0.3s ease';
                setTimeout(function () { toast.remove(); }, 300);
            }
        }, 4000);
    },

    // Confirm Dialog 
    confirm: function (message, callback) {
        $('#confirmModal .modal-body').text(message);
        $('#confirmModal').modal('show');
        $('#confirmModal .btn-confirm').off('click').on('click', function () {
            $('#confirmModal').modal('hide');
            if (callback) callback();
        });
    },

    // Format Date
    formatDate: function (dateStr) {
        if (!dateStr) return '-';
        const d = new Date(dateStr);
        return d.toLocaleDateString('id-ID', { day: '2-digit', month: 'short', year: 'numeric' });
    },

    formatDateTime: function (dateStr) {
        if (!dateStr) return '-';
        const d = new Date(dateStr);
        return d.toLocaleDateString('id-ID', { day: '2-digit', month: 'short', year: 'numeric' }) +
            ' ' + d.toLocaleTimeString('id-ID', { hour: '2-digit', minute: '2-digit' });
    },

    // Format Currency
    formatCurrency: function (amount) {
        if (amount === null || amount === undefined) return 'Rp 0';
        return 'Rp ' + Number(amount).toLocaleString('id-ID');
    },

    // Table Builder 
    buildTable: function (tableId, columns, data, actions) {
        const tbody = $('#' + tableId + ' tbody');
        tbody.empty();

        if (!data || data.length === 0) {
            tbody.append('<tr><td colspan="' + (columns.length + (actions ? 1 : 0)) +
                '" class="text-center text-muted py-4"><i class="fas fa-inbox fa-2x mb-2 d-block"></i>No data available</td></tr>');
            return;
        }

        data.forEach(function (row, index) {
            let tr = '<tr>';
            columns.forEach(function (col) {
                let value = row[col.field];
                if (col.formatter) {
                    value = col.formatter(value, row);
                }
                tr += '<td>' + (value !== null && value !== undefined ? value : '-') + '</td>';
            });

            if (actions) {
                tr += '<td class="text-center">' + actions(row, index) + '</td>';
            }
            tr += '</tr>';
            tbody.append(tr);
        });
    },

    buildPagination: function (containerId, currentPage, totalPages, callback) {
        const container = $('#' + containerId);
        container.empty();

        if (totalPages <= 1) return;

        let html = '<nav><ul class="pagination pagination-sm justify-content-center mb-0">';

        // Previous
        html += '<li class="page-item ' + (currentPage === 0 ? 'disabled' : '') + '">';
        html += '<a class="page-link" href="#" data-page="' + (currentPage - 1) + '">&laquo;</a></li>';

        // Pages
        const start = Math.max(0, currentPage - 2);
        const end = Math.min(totalPages, currentPage + 3);

        for (let i = start; i < end; i++) {
            html += '<li class="page-item ' + (i === currentPage ? 'active' : '') + '">';
            html += '<a class="page-link" href="#" data-page="' + i + '">' + (i + 1) + '</a></li>';
        }

        // Next
        html += '<li class="page-item ' + (currentPage >= totalPages - 1 ? 'disabled' : '') + '">';
        html += '<a class="page-link" href="#" data-page="' + (currentPage + 1) + '">&raquo;</a></li>';

        html += '</ul></nav>';
        container.html(html);

        container.find('.page-link').on('click', function (e) {
            e.preventDefault();
            const page = parseInt($(this).data('page'));
            if (page >= 0 && page < totalPages) {
                callback(page);
            }
        });
    },

    showLoading: function (targetId) {
        $('#' + targetId).html(
            '<div class="text-center py-5">' +
            '<div class="spinner-border text-primary" role="status">' +
            '<span class="sr-only">Loading...</span></div>' +
            '<p class="mt-2 text-muted">Loading data...</p></div>'
        );
    },

    hideLoading: function (targetId) {
        // Will be replaced by actual content
    }
};

// Global Initialization
document.addEventListener('configLoaded', function() {
    // Sidebar toggle & active state
    // Toggle submenu
    $('.sidebar-menu .has-submenu > a').on('click', function(e) {
        e.preventDefault();
        $(this).parent().toggleClass('open');
    });

    // Mobile toggle
    $('#sidebarToggle').on('click', function() {
        $('#sidebar').toggleClass('show');
    });

    // Highlight current page
    var currentPath = window.location.pathname;
    
    // Find matching link (exact or prefix for subpages, excluding root dashboard)
    var $activeLink = $('.sidebar-menu a').filter(function() {
        var href = $(this).attr('href');
        return href && href !== '#' && (currentPath === href || (href !== '/dashboard' && currentPath.startsWith(href)));
    });

    if ($activeLink.length > 0) {
        $activeLink.first().addClass('active');
        $activeLink.first().closest('.has-submenu').addClass('open');
    }

    // Show username in header
    if ($('#currentUser').length > 0) {
        $('#currentUser').text(Auth.getUser());
    }
});
