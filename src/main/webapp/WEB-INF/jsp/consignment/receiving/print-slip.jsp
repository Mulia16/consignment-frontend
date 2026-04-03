<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Consignment Stock Receiving Slip</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <style>
        body { 
            background: #cbd5e1; 
            font-family: Arial, sans-serif; 
            font-size: 12px; 
            color: #000;
        }
        .page-a4 { 
            background: #fff; 
            width: 210mm; 
            min-height: 297mm; 
            margin: 20px auto; 
            padding: 15mm; 
            box-shadow: 0 0 10px rgba(0,0,0,0.1); 
            position: relative;
        }
        .section-header { border-bottom: 2px solid #000; padding-bottom: 10px; margin-bottom: 10px; }
        .company-name { font-size: 16px; font-weight: bold; margin-bottom: 5px; }
        .doc-title { font-size: 20px; font-weight: bold; color: #6c757d; text-align: right; text-transform: uppercase;}
        
        .address-block { width: 33%; float: left; padding-right: 15px; }
        .info-block { width: 34%; float: right; font-weight: bold; line-height: 1.6; }
        .info-block span { display: inline-block; width: 140px; }
        
        .clearfix::after { content: ""; clear: both; display: table; }
        
        table.slip-table { width: 100%; border-collapse: collapse; margin-top: 15px; margin-bottom: 20px; }
        table.slip-table th { border-top: 2px solid #000; border-bottom: 2px solid #000; padding: 6px 4px; text-align: center; }
        table.slip-table td { padding: 6px 4px; vertical-align: top; }
        table.slip-table .text-right { text-align: right; }
        table.slip-table .text-center { text-align: center; }
        
        .footer-sec { margin-top: 40px; border-top: 1px solid #000; padding-top: 10px; }
        .signature-line { border-top: 1px solid #000; width: 250px; margin-top: 60px; text-align: center; padding-top: 5px; }
        
        @media print {
            body { background: #fff; margin: 0; padding: 0; }
            .page-a4 { box-shadow: none; margin: 0; padding: 10mm; width: 100%; }
        }
    </style>
</head>
<body>

<div class="page-a4" id="printArea">
    <!-- Header -->
    <div class="section-header clearfix">
        <div style="float:left; width: 50%;">
            <div class="company-name">ALPRO PHARMACY SDN BHD</div>
            <div>UNIT V1-A, LOT 45880, JALAN TECHVALLEY 3<br>SENDAYAN TECHVALLEY, BANDAR SRI SENDAYAN<br>71950 BANDAR SRI SENDAYAN<br>NEGERI SEMBILAN, MALAYSIA</div>
            <div style="margin-top: 5px;"><strong>TEL :</strong> 6067813923</div>
        </div>
        <div style="float:right; width: 50%; text-align: right;">
            <div class="doc-title">Consignment Stock Receiving</div>
            <!-- Barcode mockup -->
            <div style="margin-top: 15px;">
                <img src="https://barcode.tec-it.com/barcode.ashx?data=101300075719&code=Code128&translate-esc=on" alt="Barcode" style="max-height: 40px;">
            </div>
        </div>
    </div>

    <!-- Details -->
    <div class="clearfix">
        <div class="address-block">
            <strong>TO :</strong><br>
            AUSTAR MARKETING SDN BHD<br>
            0000542010 - MD-00001<br>
            NO.22-B, LOT 3446, NO.23-A, LOT 3447,<br>
            MUARA TEBAS LAND DISTRICT, OFF JALAN<br>
            93350 KUCHING<br>
            SARAWAK<br>
            <strong>TEL :</strong> 60168648770<br>
            <strong>FAX :</strong>
        </div>
        
        <div class="address-block">
            <strong>SHIP TO :</strong><br>
            1013<br>
            KOTA KINABALU WAREHOUSE<br>
            Lot 12 (Type A2), Industri E33 Likas, Mile 2 1/2<br><br>
            88300 Kota Kinabalu<br>
            SABAH MALAYSIA<br>
            <strong>TEL :</strong> 6067813923<br>
            <strong>FAX :</strong>
        </div>
        
        <div class="info-block">
            <div><span>RECEIVED DATE</span> : <span id="lblReceivedDate">2025-09-09 10:06:23</span></div>
            <div><span>RECEIVING NUMBER</span> : <span id="lblDocNumber">101300075719</span></div>
            <div><span>PAGE</span> : 1/1</div>
        </div>
    </div>

    <!-- Items -->
    <table class="slip-table">
        <thead>
            <tr>
                <th width="40">NO</th>
                <th>ITEM</th>
                <th width="80">UOM</th>
                <th width="120" class="text-right">QTY</th>
            </tr>
        </thead>
        <tbody id="itemsBody">
            <!-- Mock items -->
            <tr>
                <td class="text-center">1</td>
                <td>
                    100321587<br>
                    (B)MORINAGA CHIL-KID<br>
                    600G (NO ADDED SUCR)<br>
                    2026-09-11 1W050W775
                </td>
                <td class="text-center">UNIT</td>
                <td class="text-right">24.000000</td>
            </tr>
            <tr>
                <td class="text-center">2</td>
                <td>
                    100478973<br>
                    MORINAGA CHIL-KID (OISHI)<br>
                    900G (NO ADDED)<br>
                    2027-03-13 1W69W075
                </td>
                <td class="text-center">UNIT</td>
                <td class="text-right">12.000000</td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <th colspan="3" class="text-right">TOTAL</th>
                <th class="text-right border-bottom" style="border-top: 2px solid #000;" id="lblTotalQty">36.000000</th>
            </tr>
        </tfoot>
    </table>

    <div class="footer-sec clearfix">
        <div style="margin-bottom: 50px;">
            <strong>REMARKS :</strong> <span id="lblRemark"></span>
        </div>
        
        <div style="float:left; font-weight: bold;">
            <div class="signature-line">
                RECEIVED BY : null STEFFENY BALASIUS
            </div>
        </div>
        <div style="float:right; font-weight: bold;">
            <div class="signature-line" style="margin-top: 60px;"> <!-- aligned with above -->
                AUTHORISED SIGNATURE
            </div>
        </div>
    </div>
</div>

<script>
    // Simulate loading basic info if ID is passed
    document.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);
        const docId = urlParams.get('id');
        if(docId) {
            // A real app would fetch data via ApiClient using docId
            // Here we just map some mocks if it's docId 1 or 2
            if(parseInt(docId) === 1) {
                document.getElementById('lblDocNumber').innerText = '000100006295';
            } else if (parseInt(docId) === 2){
                document.getElementById('lblDocNumber').innerText = '000100006294';
                document.getElementById('itemsBody').innerHTML = `
                    <tr><td class="text-center">1</td><td>100152275<br>ITEM WON INDENT GENERAL 1</td><td class="text-center">UNIT</td><td class="text-right">22.000000</td></tr>
                `;
                document.getElementById('lblTotalQty').innerText = "22.000000";
            }
        }
        
        // Auto-print prompt
        setTimeout(() => {
            window.print();
        }, 500);
    });
</script>

</body>
</html>
