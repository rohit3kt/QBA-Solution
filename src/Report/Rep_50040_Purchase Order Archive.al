// report 50040 "Purchase Order Archive"
// {
//     PreviewMode = PrintLayout;
//     ApplicationArea = All;
//     UsageCategory = ReportsAndAnalysis;
//     Caption = 'Purchase Order Report';
//     DefaultRenderingLayout = LayoutName;

//     dataset
//     {
//         dataitem("Purchase Header Archive"; "Purchase Header Archive")
//         {
//             DataItemTableView = SORTING("Document Type", "No.", "Doc. No. Occurrence", "Version No.");//
//             RequestFilterFields = "No.";
//             RequestFilterHeading = 'Purchase Order Archive';
//             column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
//             { }
//             column(Buy_from_Address; "Buy-from Address" + "Buy-from Address 2")
//             {

//             }
//             // column(Buy_from_Address_2; "Buy-from Address 2")
//             // { }
//             column(Buy_from_City; "Buy-from City" + '   ' + "Buy-from Post Code")
//             { }
//             column(Buy_from_Post_Code; "Buy-from Post Code")
//             { }
//             column(Buy_from_Contact_No_; "Buy-from Contact No.")
//             { }
//             column(Vendor_GST_Reg__No_; 'GSTIN:' + '' + "Vendor GST Reg. No.")
//             { }
//             column(Location_State_Code; "Location State Code")
//             { }
//             // Manoj Temp Commented
//             // column(State; State)
//             // { }
//             column(PONo_; "No.")
//             { }
//             column(Posting_Date; "Posting Date")
//             { }
//             column(Payment_Terms_Code; "Payment Terms Code")
//             { }
//             column(Shipment_Method_Code; "Shipment Method Code")
//             { }
//             column(ComapanyName; Rec_CompanyInfo.Name)
//             {

//             }
//             column(ComapanyAddress; Rec_CompanyInfo.Address + Rec_CompanyInfo."Address 2")
//             {
//             }
//             column(ComapanyCity; Rec_CompanyInfo.City + '  ' + Rec_CompanyInfo."Post Code")
//             {

//             }
//             column(CompanyGSTRegNo; 'GSTIN :' + Rec_CompanyInfo."GST Registration No.")
//             {

//             }
//             column(CompanyStatecode; 'State:' + STATENAME + ',' + 'Code:' + STATECODE)
//             { }
//             column(StateCode; 'State:' + STATENAME1 + ',' + 'Code:' + STATECODE1)
//             { }
//             column(CompanyEmail; 'E-Mail : ' + Rec_CompanyInfo."E-Mail")
//             { }
//             column(Terms_Conditions; Terms_Conditions)
//             { }
//             column(SRNo; SRNo)
//             { }
//             column(Location_Code; "Location Code")
//             { }
//             column(Headlable1; Headlable1)
//             { }
//             column(terms_Condition; "terms&Condition")
//             { }
//             column(terms_condition1; "terms&condition1")
//             { }
//             column(TerText; TerText)
//             { }
//             //Manoj Temp Commented
//             // column(Bar_Code; "Bar Code")
//             // { }
//             //Manoj Temp Commented
//             column(Ship_to_Name; "Ship-to Name")
//             { }
//             column(Ship_to_Address; "Ship-to Address" + ' ' + "Ship-to Address 2")
//             {
//             }
//             column(Ship_to_City; "Ship-to City" + ' ' + "Ship-to Post Code")
//             { }
//             column(ShipStateCode; 'State:' + STATENAME1 + ',' + 'Code:' + STATECODE1)
//             { }
//             column(ShipGSTRegNo; 'GSTIN :' + "Location GST Reg. No.")
//             {

//             }
//             column(BarCode; BarCode)
//             { }
//             column(shiptoEmail; 'Email: ' + shiptoEmail)
//             { }
//             column(shiptoPhoneNO; 'Phone No. : ' + shiptoPhoneNO) { }
//             //Manoj Temp Commented
//             // column(Quote_No_; 'Quote No.: ' + "Quote No.")
//             // { }
//             // column(Quote_Date; 'Quote Date: ' + Format("Quote Date"))
//             // { }
//             //Manoj Temp Commented
//             column(remarks1; 'Remarks: ' + remarks1)
//             { }
//             column(InvoiceToAddress; InvoiceToAddress) { }
//             column(InvoiceToCity; InvoiceToCity) { }
//             column(InvoiceToGStRegNo; 'GSTIN :' + InvoiceToGStRegNo) { }
//             column(InvoiceToStateCode; InvoiceToStateCode) { }
//             column(InvoiceToEmail; 'E-Mail : ' + InvoiceToEmail) { }
//             column(InvoiceToPhoneNo; 'Phone No : ' + InvoiceToPhoneNo) { }
//             column(VendorPhoneNo; 'Phone No : ' + VendorPhoneNo) { }
//             column(VendorEmailID; 'Email ID : ' + VendorEmailID) { }
//             column(Symbol; Symbol) { }
//             column(ShipToAddress; ShipToAddress) { }
//             column(ShipToCity; ShipToCity) { }
//             column(ShipToGStRegNo; ShipToGStRegNo) { }
//             column(ShipToStateCode; ShipToStateCode) { }
//             column(ApprovedBy; ApprovedBy) { }
//             column(ApprovalDate; ApprovalDate) { }
//             column(Status; Status) { }
//             dataitem("Purchase Line Archive"; "Purchase Line Archive")
//             {
//                 DataItemLink = "Document Type" = FIELD("Document Type"),
//                                "Document No." = FIELD("No."),
//                                "Version No." = field("Version No.");
//                 DataItemLinkReference = "Purchase Header Archive";
//                 DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
//                 column(Description; Description)
//                 { }
//                 column(Type; Type)
//                 { }
//                 column(Expected_Receipt_Date; "Purchase Line Archive"."Expected Receipt Date")
//                 { }
//                 column(Quantity; Quantity)
//                 { }
//                 column(Direct_Unit_Cost; "Direct Unit Cost")
//                 { }
//                 column(Unit_of_Measure_Code; "Unit of Measure Code")
//                 { }
//                 column(Line_Discount__; "Line Discount %")
//                 { }
//                 column(Line_Amount; "Line Amount")
//                 { }
//                 column(SGSTPer; SGSTPer)
//                 {
//                 }
//                 column(CGSTPer; CGSTPer)
//                 {
//                 }
//                 column(IGSTPer; IGSTPer)
//                 {
//                 }
//                 column(HSN_SAC_Code; "HSN/SAC Code")
//                 {

//                 }
//                 column(CGSTAmt; CGSTAmt)
//                 { }
//                 column(SGSTAmt; SGSTAmt)
//                 { }
//                 column(IGSTAmt; IGSTAmt)
//                 { }
//                 column(Document_Type; "Document Type")
//                 { }
//                 column(TempHSN; 'TempHSN.Code')
//                 {

//                 }
//                 column(Total; Total)
//                 { }
//                 column(AmountInWords1; Saying1[1] + ' ' + Saying1[2])
//                 {
//                 }
//                 column(AmountInWords2; Saying2[1] + ' ' + Saying2[2])
//                 {
//                 }
//                 column(totaltaxableValue; 'TempHSN.TotalAmount')
//                 { }

//                 column(Amttotal; Amttotal)
//                 {
//                 }
//                 column(Line_No_; "Line No.") { }

//                 trigger OnPreDataItem()
//                 begin

//                 end;

//                 trigger OnAfterGetRecord()
//                 var
//                     //GSTSetup: Record "GST Setup";
//                     i: Integer;
//                 begin
//                     if "Purchase Line Archive".Type <> "Purchase Line Archive".Type::" " then
//                         SRNo := SRNo + 1;

//                     // GenLedSetupG.Get();
//                     // if "Currency Code" = '' then
//                     //     CurrCodeG := GenLedSetupG."LCY Code"
//                     // else
//                     //     CurrCodeG := "Currency Code";

//                     GSTSetup.Get();
//                     GetGSTCaptions(TaxTrnasactionValue, "Purchase Line Archive", GSTSetup);
//                     GetGSTAmounts(TaxTrnasactionValue, "Purchase Line Archive", GSTSetup);
//                     AmtInWordsG.InitTextVariable();
//                     AmtInWordsG.FormatNoText(Saying1, Amttotal, CurrCodeG);
//                     AmtInWordsG.FormatNoText(Saying2, Total, CurrCodeG);

//                 END;

//                 trigger OnPostDataItem()
//                 begin

//                 end;

//             }
//             // dataitem("Integer"; "Integer")
//             // {
//             //     column(EmptyLines; Integer.Number)
//             //     {
//             //     }

//             //     trigger OnPreDataItem()
//             //     begin
//             //         IF SRNo MOD 10 >= 1 THEN
//             //             Integer.SETRANGE(Number, 1, 10 - (SRNo MOD 10))
//             //         ELSE
//             //             CurrReport.BREAK

//             //     end;
//             // }

//             trigger OnAfterGetRecord()
//             begin
//                 //SRNo := SRNo + 1;
//                 StateG.Reset();
//                 StateG.SetRange(Code, Rec_CompanyInfo."State Code");
//                 if StateG.FindFirst() then begin
//                     STATENAME := StateG.Description;
//                     STATECODE := StateG."State Code (GST Reg. No.)";
//                 end;
//                 // StateG.Reset();
//                 // StateG.SetRange(Code, "Purchase Header".State);
//                 // if StateG.FindFirst() then begin
//                 //     STATENAME1 := StateG.Description;
//                 //     STATECODE1 := StateG."State Code (GST Reg. No.)";
//                 // end;
//                 // if StateG.Get("Location State Code") then begin
//                 //     STATENAME1 := StateG.Description;
//                 //     STATECODE1 := StateG."State Code (GST Reg. No.)";
//                 // end;

//                 // LocationG.Reset();
//                 // LocationG.SetRange(Code, "Purchase Header"."Location Code");
//                 // if LocationG.FindFirst() then begin
//                 //     shiptoEmail := LocationG."E-Mail";
//                 // end;

//                 PurchCommentLine.Reset();
//                 PurchCommentLine.SetRange("No.", "Purchase Header Archive"."No.");
//                 PurchCommentLine.SetRange("Version No.", "Purchase Header Archive"."Version No.");
//                 if PurchCommentLine.FindFirst() then
//                     repeat
//                         remarks := PurchCommentLine.Comment;
//                         remarks1 := remarks1 + ',' + remarks;
//                     until PurchCommentLine.Next() = 0;
//                 BarCodeStr := "No.";
//                 BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
//                 BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";
//                 BarcodeFontProvider.ValidateInput(BarCodeStr, BarcodeSymbology);
//                 BarCode := BarcodeFontProvider.EncodeFont(BarCodeStr, BarcodeSymbology);
//                 //Manoj temp commented
//                 // if "Purchase Header".Subcontractor then
//                 //     Headlable1 := 'Job Work Order'
//                 // else
//                 //     Headlable1 := 'Purchase Order';
//                 //Manoj temp commented

//                 // >> 28.04.2024 RKS
//                 if "Purchase Header Archive"."Bill to-Location(POS)" <> '' then begin
//                     LocationG.Get("Bill to-Location(POS)");
//                     InvoiceToAddress := LocationG.Address + ', ' + LocationG."Address 2";
//                     InvoiceToCity := LocationG.City + '  ' + LocationG."Post Code";
//                     InvoiceToGStRegNo := LocationG."GST Registration No.";
//                     StateG.Get(LocationG."State Code");
//                     InvoiceToStateCode := 'State:' + StateG.Description + ',' + 'Code:' + StateG."State Code (GST Reg. No.)";
//                     InvoiceToEmail := LocationG."E-Mail";
//                     InvoiceToPhoneNo := LocationG."Phone No.";
//                 end else begin
//                     LocationG.Get("Location Code");
//                     InvoiceToAddress := LocationG.Address + ', ' + LocationG."Address 2";
//                     InvoiceToCity := LocationG.City + '  ' + LocationG."Post Code";
//                     InvoiceToGStRegNo := LocationG."GST Registration No.";
//                     StateG.Get(LocationG."State Code");
//                     InvoiceToStateCode := 'State:' + StateG.Description + ',' + 'Code:' + StateG."State Code (GST Reg. No.)";
//                     InvoiceToEmail := LocationG."E-Mail";
//                     InvoiceToPhoneNo := LocationG."Phone No.";
//                 end;

//                 Grec_Vendor.Get("Buy-from Vendor No.");
//                 VendorPhoneNo := Grec_Vendor."Phone No.";
//                 VendorEmailID := Grec_Vendor."E-Mail";

//                 if (("Currency Code" = '') OR ("Currency Code" = 'INR')) then
//                     Symbol := '₹'
//                 else if "Currency Code" = 'USD' then
//                     Symbol := '$'
//                 else if "Currency Code" = 'EUR' then
//                     Symbol := '€'
//                 else if "Currency Code" = 'GBP' then
//                     Symbol := '£'
//                 else
//                     Symbol := '';

//                 if "Purchase Header Archive"."Location Code" <> '' then begin
//                     LocationG.Get("Location Code");
//                     ShipToAddress := LocationG.Address + ' ' + LocationG."Address 2";
//                     ShipToCity := LocationG.City + ' ' + LocationG."Post Code";
//                     ShipToGStRegNo := LocationG."GST Registration No.";
//                     StateG.Get(LocationG."State Code");
//                     ShipToStateCode := 'State:' + StateG.Description + ',' + 'Code:' + StateG."State Code (GST Reg. No.)";
//                     shiptoEmail := LocationG."E-Mail";
//                     shiptoPhoneNO := LocationG."Phone No.";
//                 end;

//                 // >> 003 
//                 GenLedSetupG.Get();
//                 if "Currency Code" = '' then
//                     CurrCodeG := GenLedSetupG."LCY Code"
//                 else
//                     CurrCodeG := "Currency Code";
//                 // << 003

//                 PostedPuchHdrG.Reset();
//                 PostedPuchHdrG.SetRange("Order No.", "Purchase Header Archive"."No.");
//                 if PostedPuchHdrG.FindFirst() then begin
//                     ApprovalEntryG.Reset();
//                     ApprovalEntryG.SetCurrentKey("Sequence No.");
//                     ApprovalEntryG.SetRange("Table ID", 122);
//                     // ApprovalEntryG.SetRange("Document Type", ApprovalEntryG."Document Type"::Invoice);
//                     ApprovalEntryG.SetRange("Document No.", PostedPuchHdrG."No.");
//                     ApprovalEntryG.SetRange(Status, ApprovalEntryG.Status::Approved);
//                     ApprovalEntryG.SetAscending("Sequence No.", true);
//                     if ApprovalEntryG.FindLast() then begin
//                         UsersInfo.Reset();
//                         UsersInfo.SetRange("User Name", ApprovalEntryG."Approver ID");
//                         if UsersInfo.FindFirst() then begin
//                             ApprovedBy := UsersInfo."Full Name";
//                             ApprovalDate := ApprovalEntryG."Last Date-Time Modified";
//                         end;
//                     end;
//                 end;
//                 // >> RKS 06.06.2024
//                 if StateG.Get(Grec_Vendor."State Code") then begin
//                     STATENAME1 := StateG.Description;
//                     STATECODE1 := StateG."State Code (GST Reg. No.)";
//                 end;
//                 // << RKS 06.06.2024
//             end;

//             trigger OnPreDataItem()
//             var
//             // CalcHSNSACSumCodeunit: Codeunit "CalculateHSNSACSum";
//             begin
//                 //"Purchase Header".SetFilter("No.", '%1', No);
//                 SRNo := 0;
//                 Rec_CompanyInfo.Get();
//                 //StateG.Get();
//                 // if Terms_Conditions then begin
//                 //     TerText := '<br>' + Text032 + '</br>' +
//                 //     '<br>' + Text033 + '</br>' + '<br>' + Text034 + '</br>';
//                 // end else
//                 //     TerText := '';
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(Content)
//             {
//                 group(General)
//                 {
//                     Caption = 'Filter : Purchase Order';
//                     field(Terms_Conditions; Terms_Conditions)
//                     {
//                         ApplicationArea = all;
//                     }
//                     // field(No; No)
//                     // {
//                     //     ApplicationArea = all;
//                     //     TableRelation = "Purchase Header"."No.";
//                     //     //ValidateTableRelation=false;

//                     // }
//                 }

//             }
//         }

//         actions
//         {
//         }
//     }
//     rendering
//     {
//         layout(LayoutName)
//         {
//             Type = RDLC;
//             LayoutFile = './src/Report Layout/Purchase Order Archive.rdl';
//         }
//     }
//     trigger OnPreReport()
//     begin
//         Clear(Headlable1);



//     end;

//     var
//         PostedPuchHdrG: Record "Purch. Inv. Header";
//         ApprovalDate: DateTime;
//         ApprovalTime: Text[80];
//         Saying1: array[2] of Text[500];
//         Saying2: array[2] of Text[500];
//         remarks1: text;
//         remarks: text;
//         PurhCmtLineG: Record "Purch. Comment Line Archive";
//         shiptoEmail: Text[50];
//         shiptoPhoneNO: Text[50];
//         LocationG: Record Location;
//         BarCode: Text;
//         BarCodeStr: Code[30];
//         BarcodeSymbology: Enum "Barcode Symbology";
//         BarcodeFontProvider: Interface "Barcode Font Provider";
//         TerText: Text;
//         No: Code[20];
//         Headlable1: Text[20];

//         STATENAME1: text[100];
//         STATECODE1: Code[20];
//         Account_No: Text[30];
//         Bank_Name: Text[20];
//         Bank_Address: Text[100];
//         IFSC_Code: Text[20];
//         CentText: Text[30];

//         AmtInWordsG: Codeunit "Amount In Words";
//         STATENAME: Text[100];
//         STATECODE: Code[10];
//         StateG: Record State;
//         vendorRec: Record Vendor;
//         paymenttermsrec: Record "Payment Terms";
//         shipmentmethodrec: Record "Shipment Method";
//         statesrec: Record State;
//         locationsrec: Record Location;
//         SRNo: Integer;
//         Var_Country: Integer;
//         Terms_Conditions: Boolean;
//         Rec_CompanyInfo: Record "Company Information";
//         CGSTPer: Decimal;
//         SGSTPer: Decimal;
//         CGSTAmt: Decimal;
//         SGSTAmt: Decimal;
//         IGSTPer: Decimal;
//         IGSTAmt: Decimal;
//         "Terms&Conditions": Boolean;
//         TotalAmtinWords: Decimal;
//         DetGSTLegEnt: Record "Detailed GST Entry Buffer";
//         TaxTrnasactionValue: Record "Tax Transaction Value";
//         GenLedSetupG: Record "General Ledger Setup";
//         CurrCodeG: Code[10];
//         TotSGSTAmt: Decimal;
//         TotCGSTAmt: Decimal;
//         TotIGSTAmt: Decimal;
//         Rec_PL: Record "Purchase Line";
//         Amt_Var: Decimal;
//         Total_Amt_Var: Decimal;
//         CGSTAmt1: Decimal;
//         SGSTAmt1: Decimal;
//         IGSTAmt1: Decimal;
//         TotSGSTAmt1: Decimal;
//         TotCGSTAmt1: Decimal;
//         TotIGSTAmt1: Decimal;
//         // AmtInWords: array[2] of Text[100];
//         Total_Amt_Var1: Decimal;
//         Charges_Var: Decimal;
//         Charges_Var1: Integer;
//         Charges_Var2: Integer;
//         Charges_Var3: Integer;
//         //  PstedStrOrdLineDet: Record "Structure Order Line Details";//JB17072023
//         FreAmt: Decimal;
//         CGSTPer1: Decimal;
//         SGSTPer1: Decimal;
//         IGSTPer1: Decimal;
//         amttovendor: Decimal;
//         Numberofrec: Integer;
//         CurrencyCode: Code[10];
//         statedesc: Text;
//         GRec_ShippingAgent: Record "Shipping Agent";
//         Gvar_ShipAgent_Desc: Text[50];
//         Gvar_GSTPer: Decimal;
//         Grec_State: Record State;
//         Grec_Vendor: Record Vendor;
//         Gvar_StateCode: Code[10];
//         Gvar_StateName: Text[30];
//         Gvar_GSTAmt: Decimal;
//         Gvar_GSTPercentage: Integer;
//         Gvar_PurchAmtLcy: Decimal;
//         Gvar_Location1: Record "Ship-to Address";
//         Gvar_Location: Text[50];
//         GRec_Location: Record Location;
//         Gvar_LName: Text[50];
//         Gvar_LName1: Text[50];
//         Gvar_LAddress: Text[50];
//         Gvar_LAddress1: Text[50];
//         Gvar_LAddress2: Text[50];
//         Gvar_LAddress3: Text[50];
//         Gvar_LPostCode: Code[10];
//         Gvar_LPostCode1: Code[10];
//         Gvar_LCity: Text[50];
//         Gvar_LCity1: Text[50];
//         Gvar_LStateCode: Code[10];
//         Gvar_LStateCode1: Code[10];
//         Gvar_LStateName: Code[50];
//         Gvar_LStateName1: Code[50];
//         Gvar_LStateGST_Reg_No: Code[10];
//         Gvar_LStateGST_Reg_No1: Code[10];
//         Gvar_LContact: Text;
//         Gvar_LGST_Reg_No: Code[30];
//         GRECUser: Record User;
//         AssignedUser: Text[250];
//         PurchCommentLine: Record "Purch. Comment Line Archive";
//         CommentNote: Text[250];
//         PurchaseHeaderArchive: Record "Purchase Header Archive";
//         ModifiedDate: Date;
//         PageVar: Integer;
//         ApprovalEntryG: Record "Posted Approval Entry";
//         UsersInfo: Record User;
//         ApprovedBy: Text;
//         GSTComponentCodeName: array[10] of Code[20];
//         GSTCESSLbl: Label 'GST CESS';
//         GSTLbl: Label 'GST';
//         CGSTLbl: Label 'CGST';
//         SGSTLbl: Label 'SGST';
//         IGSTLbl: Label 'IGST';
//         CessLbl: Label 'CESS';
//         Total: Decimal;
//         //TempHSN: record TempRecordforHSNcode;
//         Total1: Decimal;
//         Amttotal: Decimal;
//         "terms&Condition": Label 'Terms & conditions: 1.Vendor will supply only to the extent of quantity mentioned in the PO. We’re not liable to pay if the supply is higher than PO quantity. We’ll not take responsibility for any excess quantity supplied. Vendor will arrange the returns of excesses by his own. Rejection of any material will be returned on a debit basis, and if the rejection is repeated, the supplier will be penalized. Logistics and related cost towards return will be borne by vendor. Unit rate mentioned in the purchase order is final and binding for both.2. Material will be supplied by vendor and subsequently accepted by HIPL as per the approved sample (As per PO) in terms of size, design, and specification, and it should also clear all the testing and inspection parameters as per policy of HIPL.3. Delivery of the material should be as per the agreed time mentioned in PO, else late delivery cause will attract as per PO.4. Any reision of purchase order will be either through a new purchase order or the revision of existing purchase order.5. The cost of reverse logistics and replacement of the rejected material will be borne by the supplier.6.Testing standards should be as per the policy of HIPL.7. Material should reach the factory in good condition only.8. Any defective or damage quantity will be returned to vendor by HIPL.9. HIPL will debit cost of that product along with logistics cost incurred towards return.10. In case of segregation of material is required from the supplies made due to quality issues, then HIPL will debit the vendor of INR 1000/- per day for the number of days taken for those segregation.11. Jurisdiction of dispute resolution is restricted to Pondicherry only. ';
//         "terms&condition1": Label '';
//         TotalG: Decimal;
//         InvoiceToAddress: Text[150];
//         InvoiceToCity: Text[50];
//         InvoiceToGStRegNo: Code[20];
//         InvoiceToStateCode: Text[50];
//         InvoiceToEmail: Text[80];
//         InvoiceToPhoneNo: Text[80];
//         VendorPhoneNo: Text[30];
//         VendorEmailID: Text[80];
//         Symbol: Text[5];

//         ShipToAddress: Text[150];
//         ShipToCity: Text[50];
//         ShipToGStRegNo: Code[20];
//         ShipToStateCode: Text[50];
//         GSTSetup: Record "GST Setup";

//     local procedure GetGSTAmounts(TaxTransactionValue: Record "Tax Transaction Value";
//       PurchaseLine: Record "Purchase Line Archive";
//       GSTSetup: Record "GST Setup")
//     var
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

//                     Total := TotSGSTAmt + TotCGSTAmt + TotIGSTAmt;
//                 //  Total := Total + TotalG;

//                 until TaxTransactionValue.Next() = 0;
//             Total1 := Total1 + "Purchase Line Archive"."Line Amount";
//             Amttotal := Total1 + Total;

//         end;
//     end;

//     local procedure GetComponentName(PurchaseLine: Record "Purchase Line Archive";
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
//         PurchaseLine: Record "Purchase Line Archive";
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


//     /*
//     RecGLSet.GET;
//     IF NoText[1] = '' THEN
//      NoText[1] := RecGLSet."LCY Code";
//     */



// }
