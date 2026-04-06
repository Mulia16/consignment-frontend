
var BatchService = {

    
    triggerSettlement: async function(businessDate) {
        var path = '/settlement/trigger';
        if (businessDate) {
            path += '?businessDate=' + businessDate;
        }
        return ApiClient.post('BATCH', path, {});
    },

    triggerReport: async function(reportDate) {
        var path = '/report/trigger';
        if (reportDate) {
            path += '?reportDate=' + reportDate;
        }
        return ApiClient.post('BATCH', path, {});
    }
};

window.BatchService = BatchService;
