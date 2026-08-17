page 50005 "QBA Vendor Ledger Entries"
{
    //ApplicationArea = Basic, Suite;
    //Caption = 'Vendor Ledger Entries';
    DataCaptionFields = "Vendor No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Vendor Ledger Entry" = rm;
    SourceTable = "Vendor Ledger Entry";
    SourceTableView = sorting("Vendor No.", "Posting Date") order(descending);
    UsageCategory = History;
    //AdditionalSearchTerms = 'Vendor Check, Pay Vendor, Vendor Bills';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the vendor entry''s posting date.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the vendor entry''s document date.';
                }
                // field("Invoice Received Date"; Rec."Invoice Received Date")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                //     ToolTip = 'Specifies the date when the vendor''s invoice was received.';
                //     Visible = false;
                // }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the document type that the vendor entry belongs to.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the vendor entry''s document number.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the vendor account that the entry is linked to.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = VendNameVisible;
                }
                // field("Message to Recipient"; Rec."Message to Recipient")
                // {
                //     ApplicationArea = Basic, Suite;
                //     ToolTip = 'Specifies the message exported to the payment file when you use the Export Payments to File function in the Payment Journal window.';
                //     Visible = false;
                // }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ToolTip = 'Specifies a description of the vendor entry.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = Dim1Visible;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = Dim2Visible;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the vendor''s market type to link business transactions made for the vendor with the appropriate account in the general ledger.';
                    Visible = false;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = Intercompany;
                    Editable = false;
                    ToolTip = 'Specifies the code of the intercompany partner that the transaction is related to if the entry was created from an intercompany transaction.';
                    Visible = false;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the currency code for the amount on the line.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment of the purchase invoice.';
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the vendor who sent the purchase invoice.';
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount of the original entry.';
                }
                field("Original Amt. (LCY)"; Rec."Original Amt. (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount that the entry originally consisted of, in LCY.';
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount of the entry.';
                    Visible = AmountVisible;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount of the entry in LCY.';
                    Visible = AmountVisible;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits.';
                    Visible = DebitCreditVisible;
                }
                field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits, expressed in LCY.';
                    Visible = DebitCreditVisible;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits.';
                    Visible = DebitCreditVisible;
                }
                field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits, expressed in LCY.';
                    Visible = DebitCreditVisible;
                }
                field(RunningBalanceLCY; CalcRunningVendBalance.GetVendorBalanceLCY(Rec))
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Running Balance (LCY)';
                    ToolTip = 'Specifies the running balance in LCY.';
                    AutoFormatType = 1;
                    Visible = false;
                }
                field("QBA Payment Amount"; Rec."QBA Payment Amount")
                {
                    ApplicationArea = All;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount that remains to be applied to before the entry is totally applied to.';
                }
                field("Remaining Amt. (LCY)"; Rec."Remaining Amt. (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount that remains to be applied to before the entry is totally applied to.';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the type of account that a balancing entry is posted to, such as BANK for a cash account.';
                    Visible = false;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the general ledger, customer, vendor, or bank account that the balancing entry is posted to, such as a cash account for cash purchases.';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the due date on the entry.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';
                }
                field("Pmt. Disc. Tolerance Date"; Rec."Pmt. Disc. Tolerance Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the latest date the amount in the entry must be paid in order for payment discount tolerance to be granted.';
                }
                field("Original Pmt. Disc. Possible"; Rec."Original Pmt. Disc. Possible")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the discount that you can obtain if the entry is applied to before the payment discount date.';
                }
                field("Remaining Pmt. Disc. Possible"; Rec."Remaining Pmt. Disc. Possible")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the remaining payment discount which can be received if the payment is made before the payment discount date.';
                }
                field("Max. Payment Tolerance"; Rec."Max. Payment Tolerance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the maximum tolerated amount the entry can differ from the amount on the invoice or credit memo.';
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies whether the amount on the entry has been fully paid or there is still a remaining amount that must be applied to.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the related entry represents an unpaid invoice for which either a payment suggestion, a reminder, or a finance charge memo exists.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                    Visible = false;

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation(Rec."User ID");
                    end;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the source code that specifies where the entry was created.';
                    Visible = false;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the entry.';
                    Visible = false;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies if the entry has been part of a reverse transaction.';
                    Visible = false;
                }
                field("Reversed by Entry No."; Rec."Reversed by Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the correcting entry that replaced the original entry in the reverse transaction.';
                    Visible = false;
                }
                field("Reversed Entry No."; Rec."Reversed Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the original entry that was undone by the reverse transaction.';
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
                field("Exported to Payment File"; Rec."Exported to Payment File")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ToolTip = 'Specifies that the entry was created as a result of exporting a payment journal line.';

                    trigger OnValidate()
                    var
                        ConfirmManagement: Codeunit "Confirm Management";
                    begin
                        if not ConfirmManagement.GetResponseOrDefault(ExportToPaymentFileConfirmTxt, true) then
                            Error('');
                    end;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies a reference to a combination of dimension values. The actual values are stored in the Dimension Set Entry table.';
                    Visible = false;
                }
                field(RecipientBankAcc; Rec."Recipient Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the bank account to transfer the amount to.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 3, which is one of dimension codes that you set up in the General Ledger Setup window.';
                    Visible = Dim3Visible;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 4, which is one of dimension codes that you set up in the General Ledger Setup window.';
                    Visible = Dim4Visible;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 5, which is one of dimension codes that you set up in the General Ledger Setup window.';
                    Visible = Dim5Visible;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 6, which is one of dimension codes that you set up in the General Ledger Setup window.';
                    Visible = Dim6Visible;
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 7, which is one of dimension codes that you set up in the General Ledger Setup window.';
                    Visible = Dim7Visible;
                }
                field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 8, which is one of dimension codes that you set up in the General Ledger Setup window.';
                    Visible = Dim8Visible;
                }
                field("Closed at Date"; Rec."Closed at Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the date at which the vendor ledger entry was closed.';
                    Visible = false;
                }
                field("Remit-to Code"; Rec."Remit-to Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the address for the remit-to code.';
                    Visible = true;
                    TableRelation = "Remit Address".Code where("Vendor No." = field("Vendor No."));
                }
            }
        }
        area(factboxes)
        {
            part(SelectedLinesTotal; "Selected Lines Total")
            {
                Caption = 'Selected Lines Total';
                ApplicationArea = All;
                SubPageLink = Number = const(1);
            }
        }
    }

    actions
    {
        // area(navigation)
        // {
        //     group("Ent&ry")
        //     {
        //         Caption = 'Ent&ry';
        //         Image = Entry;
        //         action(AppliedEntries)
        //         {
        //             ApplicationArea = Basic, Suite;
        //             Caption = 'Applied E&ntries';
        //             Image = Approve;
        //             RunObject = Page "Applied Vendor Entries";
        //             RunPageOnRec = true;
        //             Scope = Repeater;
        //             ToolTip = 'View the ledger entries that have been applied to this record.';
        //         }
        //     }
        // }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(ExportToExcel) // Rohit
                {
                    ApplicationArea = All;
                    Caption = 'Export To Excel';//
                    Image = Process;
                    Ellipsis = true;
                    trigger OnAction()
                    var
                        InputBox: Page "Input Box";
                        //ReferenceInvoiceNo: Record "Reference Invoice No.";
                        RecBankAccount: Record "Bank Account";
                        TempAccount: Text[30];

                        TempExcelBuffer: Record "Excel Buffer" temporary;
                        GSEntriesLbl: Label 'Exported Sheet';
                        ExcelFileName: Label 'Vendor Payment File-%1-%2';
                        VendorBankAccount: Record "Vendor Bank Account";
                        RecVendor: Record Vendor;
                        QBAEventSubscriber: Codeunit "QBA Event Subscriber";

                        BeneficiaryID: Code[20];
                        BeneficiaryName: Text[100];
                        BankAccountNo: Text[30];
                        BankClearingCode: Text[50];
                    begin
                        //InputBox.LookupMode := true;
                        CurrPage.SetSelectionFilter(RecVendLedgerEntry);
                        CurrPage.SetSelectionFilter(Rec);
                        //Message('Total Seleected QBA Amount : %1', GetTotalPaymentAmount(Rec));
                        if Page.RunModal(Page::"Bank Account List", RecBankAccount) <> Action::LookupOK then
                            Error('Process has been aborted!')
                        else
                            TempAccount := RecBankAccount."Bank Account No.";

                        if not AccountStatementExist(RecBankAccount."No.") then
                            Error('Bank Account Statement is not available for this Account No.');

                        TempExcelBuffer.Reset();
                        TempExcelBuffer.DeleteAll();
                        TempExcelBuffer.NewRow();

                        TempExcelBuffer.AddColumn('PYMT_PROD_TYPE_CODE', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('PYMT_MODE', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('DEBIT_ACC_NO', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('BENE_ID', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('BNF_NAME', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('BENE_ACC_NO', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn('BENE_IFSC', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('AMOUNT', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('DEBIT_NARR', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('CREDIT_NARR', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('MOBILE_NUM', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('EMAIL_ID', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('REMARK', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('PYMT_DATE', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('REF_NO', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('ADDL_INFO1', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('ADDL_INFO2', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('ADDL_INFO3', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('ADDL_INFO4', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('ADDL_INFO5', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        if Rec.FindSet() then
                            repeat
                                Clear(BeneficiaryID);
                                Clear(BeneficiaryName);
                                Clear(BankAccountNo);
                                Clear(BankClearingCode);
                                if RecVendor.Get(Rec."Vendor No.") then;
                                VendorBankAccount.Reset();
                                VendorBankAccount.SetRange("Vendor No.", Rec."Vendor No.");
                                if VendorBankAccount.FindFirst() then begin
                                    BeneficiaryID := VendorBankAccount."Beneficiary ID";
                                    BeneficiaryName := VendorBankAccount."Beneficiary Name";
                                    BankAccountNo := VendorBankAccount."Bank Account No.";
                                    BankClearingCode := VendorBankAccount."Bank Clearing Code";
                                end;

                                TempExcelBuffer.NewRow();
                                TempExcelBuffer.AddColumn('PRB_VENDOR', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn(VendorBankAccount."Payment Mode", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn(TempAccount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn(BeneficiaryID, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn(BeneficiaryName, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn(BankAccountNo, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn(BankClearingCode, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn(Abs(Rec."QBA Payment Amount"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                                // TempExcelBuffer.AddColumn(Rec."External Document No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                // TempExcelBuffer.AddColumn(Rec."External Document No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn(RemoveSpecialCharacters(Rec."External Document No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn(RemoveSpecialCharacters(Rec."External Document No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn(RecVendor."Phone No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn(RecVendor."E-Mail", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn(WorkDate(), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                                TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                                QBAEventSubscriber.UpdateVendorLedgerEntry(Rec."Entry No.");
                            until Rec.Next() = 0;
                        //Message('Account Number : %1', TempAccount);

                        TempExcelBuffer.CreateNewBook(GSEntriesLbl);
                        TempExcelBuffer.WriteSheet(GSEntriesLbl, CompanyName, UserId);
                        TempExcelBuffer.CloseBook();
                        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
                        TempExcelBuffer.OpenExcel();
                    end;
                }
                action("Calculate Total")
                {
                    Caption = 'Calculate Total';
                    ApplicationArea = All;
                    Image = Calculate;

                    trigger OnAction()
                    var
                        VendorLedgerEntry: Record "Vendor Ledger Entry";
                        TotalAmount: Decimal;
                        TotalQuantity: Decimal;
                        LinesCount: Integer;
                        LinesAverage: Decimal;
                    begin
                        VendorLedgerEntry.Reset();
                        LinesCount := 0;
                        LinesAverage := 0;
                        TotalAmount := 0;
                        TotalQuantity := 0;
                        CurrPage.SetSelectionFilter(VendorLedgerEntry);
                        if VendorLedgerEntry.FindSet() then
                            repeat
                                VendorLedgerEntry.CalcFields("Remaining Amount");
                                LinesCount += 1;
                                TotalAmount += Abs(VendorLedgerEntry."QBA Payment Amount");
                                TotalQuantity += VendorLedgerEntry."Remaining Amount";
                            until VendorLedgerEntry.Next() = 0;
                        if LinesCount > 0 then begin
                            LinesAverage := TotalAmount / LinesCount;
                            CurrPage.SelectedLinesTotal.Page.SetTotals(LinesCount, LinesAverage, TotalAmount, TotalQuantity);
                            CurrPage.SelectedLinesTotal.Page.Update();
                        end;
                    end;
                }
                action("Clear Total")
                {
                    Caption = 'Clear Total';
                    ApplicationArea = All;
                    Image = ClearLog;
                    trigger OnAction()
                    begin
                        ClearTotal();
                    end;
                }
                action("Show Document")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Document';
                    Image = Document;
                    ShortCutKey = 'Return';
                    ToolTip = 'Show details for the posted payment, invoice, or credit memo.';

                    trigger OnAction()
                    begin
                        Rec.ShowDoc();
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';
                //"Show Document"
                actionref(ShowDocument_Promoted; "Show Document")
                {
                }
                actionref(CalculateTotal_Promoted; "Calculate Total")
                {
                }
                actionref(ClearTotal_Promoted; "Clear Total")
                {
                }
                actionref(ExportToExcel_Promoted; ExportToExcel)//
                {
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        IncomingDocument: Record "Incoming Document";
        VendLedgerEntry: Record "Vendor Ledger Entry";
    begin
        HasIncomingDocument := IncomingDocument.PostedDocExists(Rec."Document No.", Rec."Posting Date");
        HasDocumentAttachment := Rec.HasPostedDocAttachment();
        // if GuiAllowed() then
        //   CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);

        //CurrPage.SetSelectionFilter(VendLedgerEntry);
        //CurrPage.SelectedLinesTotal.Page.QBA_Amount(VendLedgerEntry,Rec."QBA Payment Amount");
    end;

    trigger OnAfterGetRecord()
    begin
        StyleTxt := Rec.SetStyle();

    end;

    trigger OnInit()
    begin
        AmountVisible := true;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", Rec);
        exit(false);
    end;

    trigger OnOpenPage()
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        ClearTotal();
        SetControlVisibility();
        SetDimVisibility();
        if (Rec.GetFilters() <> '') and not Rec.Find() then
            if Rec.FindFirst() then;

        Rec.SetRange(Exported, false);

        VendorLedgerEntry.Reset();
        if VendorLedgerEntry.FindSet() then
            repeat
                VendorLedgerEntry.CalcFields("Remaining Amt. (LCY)");
                if VendorLedgerEntry."QBA Payment Amount" <> VendorLedgerEntry."Remaining Amt. (LCY)" then begin
                    VendorLedgerEntry."QBA Payment Amount" := VendorLedgerEntry."Remaining Amt. (LCY)";
                    CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", VendorLedgerEntry);
                end;
            until VendorLedgerEntry.Next() = 0;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        //CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", RecVendLedgerEntry);
        //exit(false);
    end;

    local procedure AccountStatementExist(BankAccNo: Code[20]): Boolean
    var
        BankAccountStatement: Record "Bank Account Statement";
    begin
        BankAccountStatement.Reset();
        BankAccountStatement.SetRange("Bank Account No.", BankAccNo);
        BankAccountStatement.SetCurrentKey("Statement Date");
        BankAccountStatement.Ascending(true);
        if BankAccountStatement.FindLast() then begin
            // if BankAccountStatement."Statement Date" = WorkDate() - 1 then
            //     exit(true)
            // else
            //     exit(false);
            exit(true)
        end;
    end;

    local procedure GetTotalPaymentAmount(VendorLedgerEntry: Record "Vendor Ledger Entry"): Decimal
    var
        TempAmt: Decimal;
    begin
        Clear(TempAmt);
        if VendorLedgerEntry.FindSet() then begin
            repeat
                TempAmt += VendorLedgerEntry."QBA Payment Amount";
            until VendorLedgerEntry.Next() = 0;
        end;
        exit(TempAmt);
    end;

    local procedure ClearTotal()
    var
        TotalSelectionLines: Record "Total Selection Lines";
    begin
        TotalSelectionLines.Reset();
        TotalSelectionLines.DeleteAll();
    end;

    var
        RecVendLedgerEntry: Record "Vendor Ledger Entry";
        CalcRunningVendBalance: Codeunit "Calc. Running Vend. Balance";
        Navigate: Page Navigate;
        DimensionSetIDFilter: Page "Dimension Set ID Filter";
        HasIncomingDocument: Boolean;
        HasDocumentAttachment: Boolean;
        AmountVisible: Boolean;
        DebitCreditVisible: Boolean;
        VendNameVisible: Boolean;
        ExportToPaymentFileConfirmTxt: Label 'Editing the Exported to Payment File field will change the payment suggestions in the Payment Journal. Edit this field only if you must correct a mistake.\Do you want to continue?';

    protected var
        Dim1Visible: Boolean;
        Dim2Visible: Boolean;
        Dim3Visible: Boolean;
        Dim4Visible: Boolean;
        Dim5Visible: Boolean;
        Dim6Visible: Boolean;
        Dim7Visible: Boolean;
        Dim8Visible: Boolean;
        StyleTxt: Text;

    local procedure SetDimVisibility()
    var
        DimensionManagement: Codeunit DimensionManagement;
    begin
        DimensionManagement.UseShortcutDims(Dim1Visible, Dim2Visible, Dim3Visible, Dim4Visible, Dim5Visible, Dim6Visible, Dim7Visible, Dim8Visible);
    end;

    local procedure SetControlVisibility()
    var
        GLSetup: Record "General Ledger Setup";
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        GLSetup.Get();
        AmountVisible := not (GLSetup."Show Amounts" = GLSetup."Show Amounts"::"Debit/Credit Only");
        DebitCreditVisible := not (GLSetup."Show Amounts" = GLSetup."Show Amounts"::"Amount Only");
        PurchSetup.Get();
        VendNameVisible := PurchSetup."Copy Vendor Name to Entries";
    end;

    local procedure GetBatchRecord(var GenJournalBatch: Record "Gen. Journal Batch"; CreatePayment: Page "Create Payment")
    var
        GenJournalTemplate: Record "Gen. Journal Template";
        JournalTemplateName: Code[10];
        JournalBatchName: Code[10];
    begin
        JournalTemplateName := CreatePayment.GetTemplateName();
        JournalBatchName := CreatePayment.GetBatchNumber();

        GenJournalTemplate.Get(JournalTemplateName);
        GenJournalBatch.Get(JournalTemplateName, JournalBatchName);
    end;

    local procedure SetChangeLogEntriesFilter(var ChangeLogEntry: Record "Change Log Entry")
    begin
        ChangeLogEntry.SetRange("Table No.", Database::"Vendor Ledger Entry");
        ChangeLogEntry.SetRange("Primary Key Field 1 Value", Format(Rec."Entry No.", 0, 9));
    end;

    local procedure RemoveSpecialCharacters(InputText: Text): Text
    var
        i: Integer;
        ResultText: Text;
        Ch: Text[1];
    begin
        for i := 1 to StrLen(InputText) do begin
            Ch := CopyStr(InputText, i, 1);

            if ((Ch >= 'A') and (Ch <= 'Z')) or
               ((Ch >= 'a') and (Ch <= 'z')) or
               ((Ch >= '0') and (Ch <= '9')) or (ch = '') then
                ResultText += Ch;
        end;

        exit(ResultText);
    end;
    // procedure ShowDoc() Result: Boolean
    // var
    //     PurchInvHeader: Record "Purch. Inv. Header";
    //     PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    //     IsHandled: Boolean;
    // begin
    //     IsHandled := false;
    //     if IsHandled then
    //         exit(Result);

    //     case Rec."Document Type" of
    //         Rec."Document Type"::Invoice:
    //             if PurchInvHeader.Get(Rec."Document No.") then begin
    //                 PAGE.Run(PAGE::"Posted Purchase Invoice", PurchInvHeader);
    //                 exit(true);
    //             end;
    //         Rec."Document Type"::"Credit Memo":
    //             if PurchCrMemoHdr.Get(Rec."Document No.") then begin
    //                 PAGE.Run(PAGE::"Posted Purchase Credit Memo", PurchCrMemoHdr);
    //                 exit(true);
    //             end
    //     end;
    // end;
}

