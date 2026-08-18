// page 50029 "QBAAPIV2 - Purchase Order Tax"
// {
//     PageType = API;

//     APIPublisher = 'QBA';
//     APIGroup = 'Agentic';
//     APIVersion = 'v2.0';

//     EntityCaption = 'Purchase Order Tax';
//     EntitySetCaption = 'Purchase Order Taxes';
//     EntityName = 'purchaseOrderTax';
//     EntitySetName = 'purchaseOrderTaxes';



//     SourceTable = "Purchase Line";

//     ODataKeyFields = SystemId;

//     DelayedInsert = true;
//     Extensible = false;

//     layout
//     {
//         area(Content)
//         {
//             repeater(Group)
//             {
//                 field(id; Rec.SystemId)
//                 {
//                     Caption = 'Id';
//                     Editable = false;
//                 }

//                 field(documentNo; Rec."Document No.")
//                 {
//                     Caption = 'Document No.';
//                     Editable = false;
//                 }

//                 field(lineNo; Rec."Line No.")
//                 {
//                     Caption = 'Line No.';
//                     Editable = false;
//                 }

//                 field(documentType; Rec."Document Type")
//                 {
//                     Caption = 'Document Type';
//                     Editable = false;
//                 }

//                 field(itemNo; Rec."No.")
//                 {
//                     Caption = 'Item No.';
//                     Editable = false;
//                 }

//                 field(description; Rec.Description)
//                 {
//                     Caption = 'Description';
//                     Editable = false;
//                 }

//                 field(taxableAmount; TaxableAmount)
//                 {
//                     Caption = 'Taxable Amount';
//                     Editable = false;
//                 }

//                 field(taxPercent; TaxPercent)
//                 {
//                     Caption = 'Tax %';
//                     Editable = false;
//                 }

//                 field(taxAmount; TaxAmount)
//                 {
//                     Caption = 'Tax Amount';
//                     Editable = false;
//                 }

//                 field(amountIncludingTax; AmountIncludingTax)
//                 {
//                     Caption = 'Amount Including Tax';
//                     Editable = false;
//                 }

//                 field(taxCalculationType; TaxCalculationType)
//                 {
//                     Caption = 'Tax Calculation Type';
//                     Editable = false;
//                 }
//                 //....................18th Aug
//                 field(totalSGSTAmount; TotSGSTAmt)
//                 {
//                     Caption = 'Total SGST Amount';
//                     Editable = false;
//                 }

//                 field(totalCGSTAmount; TotCGSTAmt)
//                 {
//                     Caption = 'Total CGST Amount';
//                     Editable = false;
//                 }

//                 field(totalIGSTAmount; TotIGSTAmt)
//                 {
//                     Caption = 'Total IGST Amount';
//                     Editable = false;
//                 }

//                 field(cgstPercentage; CGSTPer)
//                 {
//                     Caption = 'CGST Percentage';
//                     Editable = false;
//                 }

//                 field(sgstPercentage; SGSTPer)
//                 {
//                     Caption = 'SGST Percentage';
//                     Editable = false;
//                 }

//                 field(cgstAmount; CGSTAmt)
//                 {
//                     Caption = 'CGST Amount';
//                     Editable = false;
//                 }

//                 field(sgstAmount; SGSTAmt)
//                 {
//                     Caption = 'SGST Amount';
//                     Editable = false;
//                 }

//                 field(igstPercentage; IGSTPer)
//                 {
//                     Caption = 'IGST Percentage';
//                     Editable = false;
//                 }

//                 field(igstAmount; IGSTAmt)
//                 {
//                     Caption = 'IGST Amount';
//                     Editable = false;
//                 }

//                 field(totalGST; TotalGST)
//                 {
//                     Caption = 'Total GST';
//                     Editable = false;
//                 }

//                 //....................18th Aug
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         CalculateTaxInformation();
//     end;

//     var
//         TaxableAmount: Decimal;
//         TaxPercent: Decimal;
//         TaxAmount: Decimal;
//         AmountIncludingTax: Decimal;
//         TaxCalculationType: Text;
//         GSTComponentCodeName: array[10] of Code[20];
//         GSTCESSLbl: Label 'GST CESS';
//         GSTLbl: Label 'GST';
//         CGSTLbl: Label 'CGST';
//         SGSTLbl: Label 'SGST';
//         IGSTLbl: Label 'IGST';
//         CessLbl: Label 'CESS';
//         TotSGSTAmt: Decimal;
//         TotCGSTAmt: Decimal;
//         TotIGSTAmt: Decimal;
//         CGSTPer: Decimal;
//         SGSTPer: Decimal;
//         CGSTAmt: Decimal;
//         SGSTAmt: Decimal;
//         IGSTPer: Decimal;
//         IGSTAmt: Decimal;
//         TotalGST: Decimal;

//     local procedure CalculateTaxInformation()
//     var
//         PurchaseLine: Record "Purchase Line";
//         GSTSetup: Record "GST Setup";
//     begin
//         GSTSetup.Get();
//         PurchaseLine.Reset();
//         PurchaseLine.SetRange("Document Type", Rec."Document Type");
//         PurchaseLine.SetRange("Document No.", Rec."No.");

//         if PurchaseLine.FindSet() then
//             repeat
//                 GetGSTAmounts(PurchaseLine, GSTSetup);
//             until PurchaseLine.Next() = 0;
//     end;


//     local procedure GetGSTAmounts(PurchaseLine: Record "Purchase Line"; GSTSetup: Record "GST Setup")
//     var
//         TaxTransactionValue: Record "Tax Transaction Value";
//         ComponentName: Code[30];
//         GSTPurchaseInvoice: Report "Purchase - Invoice GST";
//     begin
//         ComponentName := GetComponentName(PurchaseLine, GSTSetup);
//         if (PurchaseLine.Type <> PurchaseLine.Type::" ") then begin
//             TaxTransactionValue.Reset();
//             TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
//             TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
//             TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
//             TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
//             if TaxTransactionValue.FindSet() then
//                 repeat
//                     case TaxTransactionValue."Value ID" of
//                         6:
//                             begin
//                                 SGSTAmt := Round(TaxTransactionValue.Amount, GSTPurchaseInvoice.GetGSTRoundingPrecision(ComponentName));
//                                 TotSGSTAmt += SGSTAmt;
//                                 SGSTPER := TaxTransactionValue.Percent;
//                             end;
//                         2:
//                             begin
//                                 CGSTAmt := Round(TaxTransactionValue.Amount, GSTPurchaseInvoice.GetGSTRoundingPrecision(ComponentName));
//                                 TotCGSTAmt += CGSTAmt;
//                                 CGSTPER := TaxTransactionValue.Percent;
//                             end;
//                         3:
//                             begin
//                                 IGSTAmt := Round(TaxTransactionValue.Amount, GSTPurchaseInvoice.GetGSTRoundingPrecision(ComponentName));
//                                 TotIGSTAmt += IGSTAmt;
//                                 IGSTPER := TaxTransactionValue.Percent;
//                             end;

//                     end;

//                     TotalGST := TotSGSTAmt + TotCGSTAmt + TotIGSTAmt;
//                 //  Total := Total + TotalG;

//                 until TaxTransactionValue.Next() = 0;
//             // Total1 := Total1 + "Purchase Line"."Line Amount";
//             // Amttotal := Total1 + Total;

//         end;
//     end;

//     local procedure GetComponentName(PurchaseLine: Record "Purchase Line";
//            GSTSetup: Record "GST Setup"): Code[30]
//     var
//         ComponentName: Code[30];
//     begin
//         if GSTSetup."GST Tax Type" = GSTLbl then
//             if PurchaseLine."GST Jurisdiction Type" = PurchaseLine."GST Jurisdiction Type"::Interstate then
//                 ComponentName := IGSTLbl
//             else
//                 ComponentName := CGSTLbl
//         else
//             if GSTSetup."Cess Tax Type" = GSTCESSLbl then
//                 ComponentName := CESSLbl;
//         exit(ComponentName)
//     end;

//     local procedure GetGSTCaptions(TaxTransactionValue: Record "Tax Transaction Value";
//         PurchaseLine: Record "Purchase Line";
//         GSTSetup: Record "GST Setup")
//     begin
//         TaxTransactionValue.Reset();
//         TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
//         TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
//         TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
//         TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
//         if TaxTransactionValue.FindSet() then
//             repeat
//                 case TaxTransactionValue."Value ID" of
//                     6:
//                         GSTComponentCodeName[6] := SGSTLbl;
//                     2:
//                         GSTComponentCodeName[2] := CGSTLbl;
//                     3:
//                         GSTComponentCodeName[3] := IGSTLbl;
//                 end;
//             until TaxTransactionValue.Next() = 0;
//     end;
// }