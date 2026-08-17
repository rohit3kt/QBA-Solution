namespace SelfLearningCodes_Home.SelfLearningCodes_Home;

using Microsoft.Finance.GeneralLedger.Ledger;

page 50007 "GL List"
{
    ApplicationArea = All;
    Caption = 'GL List';
    PageType = List;
    SourceTable = "G/L Entry";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Account Id"; Rec."Account Id")
                {
                    ToolTip = 'Specifies the value of the Account Id field.', Comment = '%';
                }
                field("Add.-Currency Credit Amount"; Rec."Add.-Currency Credit Amount")
                {
                    ToolTip = 'Specifies the value of the Add.-Currency Credit Amount field.', Comment = '%';
                }
                field("Add.-Currency Debit Amount"; Rec."Add.-Currency Debit Amount")
                {
                    ToolTip = 'Specifies the value of the Add.-Currency Debit Amount field.', Comment = '%';
                }
                field("Additional-Currency Amount"; Rec."Additional-Currency Amount")
                {
                    ToolTip = 'Specifies the general ledger entry that is posted if you post in an additional reporting currency.';
                }
                field("Allocation Account No."; Rec."Allocation Account No.")
                {
                    ToolTip = 'Specifies the value of the Allocation Account No. field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the Amount of the entry.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ToolTip = 'Specifies the number of the ledger, customer, vendor, or bank account that the balancing entry is posted to, such as a cash account for cash purchases.';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ToolTip = 'Specifies the type of account that a balancing entry is posted to, such as BANK for a cash account.';
                }
                field("Business Unit Code"; Rec."Business Unit Code")
                {
                    ToolTip = 'Specifies the Business Unit code of the company from which the entry was consolidated.';
                }
                field("Close Income Statement Dim. ID"; Rec."Close Income Statement Dim. ID")
                {
                    ToolTip = 'Specifies the value of the Close Income Statement Dim. ID field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ToolTip = 'Specifies the total of the ledger entries that represent credits.';
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ToolTip = 'Specifies the total of the ledger entries that represent debits.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the entry.';
                }
                field("Dimension Changes Count"; Rec."Dimension Changes Count")
                {
                    ToolTip = 'Specifies the value of the Count of Dimension Changes field.', Comment = '%';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ToolTip = 'Specifies a reference to a combination of dimension values. The actual values are stored in the Dimension Set Entry table.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the entry''s Document No.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the document type that the entry belongs to.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the entry''s external document number, such as a vendor''s invoice number.';
                }
                field("FA Entry No."; Rec."FA Entry No.")
                {
                    ToolTip = 'Specifies the number of the fixed asset entry.';
                }
                field("FA Entry Type"; Rec."FA Entry Type")
                {
                    ToolTip = 'Specifies the number of the fixed asset entry.';
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ToolTip = 'Specifies the name of the account that the entry has been posted to.';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ToolTip = 'Specifies the number of the account that the entry has been posted to.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ToolTip = 'Specifies the vendor''s or customer''s trade type to link transactions made for this business partner with the appropriate ledger account according to the general posting setup.';
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    ToolTip = 'Specifies the type of transaction.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate ledger account according to the general posting setup.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ToolTip = 'Specifies the code of the intercompany partner that the transaction is related to if the entry was created from an intercompany transaction.';
                }
                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Specifies the number of the related project.';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ToolTip = 'Specifies the value of the Journal Batch Name field.', Comment = '%';
                }
                field("Journal Templ. Name"; Rec."Journal Templ. Name")
                {
                    ToolTip = 'Specifies the value of the Journal Template Name field.', Comment = '%';
                }
                field("Last Dim. Correction Entry No."; Rec."Last Dim. Correction Entry No.")
                {
                    ToolTip = 'Specifies the value of the Last Dim. Correction Entry No. field.', Comment = '%';
                }
                field("Last Dim. Correction Node"; Rec."Last Dim. Correction Node")
                {
                    ToolTip = 'Specifies the value of the Last Dim. Correction Node field.', Comment = '%';
                }
                field("Last Modified DateTime"; Rec."Last Modified DateTime")
                {
                    ToolTip = 'Specifies the value of the Last Modified DateTime field.', Comment = '%';
                }
                field("Line Narration"; Rec."Line Narration")
                {
                    ToolTip = 'Specifies the value of the Line Narration field.', Comment = '%';
                }
                field(Narration; Rec.Narration)
                {
                    ToolTip = 'Specifies the value of the Narration field.', Comment = '%';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.', Comment = '%';
                }
                field("Non-Deductible VAT Amount"; Rec."Non-Deductible VAT Amount")
                {
                    ToolTip = 'Specifies the amount of the transaction for which VAT is not applied, due to the type of goods or services purchased.';
                }
                field("Non-Deductible VAT Amount ACY"; Rec."Non-Deductible VAT Amount ACY")
                {
                    ToolTip = 'Specifies the value of the Non-Deductible VAT Amount ACY field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the entry''s posting date.';
                }
                field("Prior-Year Entry"; Rec."Prior-Year Entry")
                {
                    ToolTip = 'Specifies the value of the Prior-Year Entry field.', Comment = '%';
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order No. field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity that was posted on the entry.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the entry.';
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies if the entry has been part of a reverse transaction (correction) made by the Reverse function.';
                }
                field("Reversed Entry No."; Rec."Reversed Entry No.")
                {
                    ToolTip = 'Specifies the number of the original entry that was undone by the reverse transaction.';
                }
                field("Reversed by Entry No."; Rec."Reversed by Entry No.")
                {
                    ToolTip = 'Specifies the number of the correcting entry. If the field Specifies a number, the entry cannot be reversed again.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 3, which is one of dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 4, which is one of dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 5, which is one of dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 6, which is one of dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 7, which is one of dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 8, which is one of dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ToolTip = 'Specifies the source code that specifies where the entry was created.';
                }
                field("Source Currency Amount"; Rec."Source Currency Amount")
                {
                    ToolTip = 'Specifies the source currency amount for general ledger entries.';
                }
                field("Source Currency Code"; Rec."Source Currency Code")
                {
                    ToolTip = 'Specifies the source currency code for general ledger entries.';
                }
                field("Source Currency VAT Amount"; Rec."Source Currency VAT Amount")
                {
                    ToolTip = 'Specifies the source currency VAT amount for general ledger entries.';
                }
                field("Source No."; Rec."Source No.")
                {
                    ToolTip = 'Specifies the number of the source document that the entry originates from.';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ToolTip = 'Specifies the source type that applies to the source number that is shown in the Source No. field.';
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                    ToolTip = 'Specifies the value of the System-Created Entry field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ToolTip = 'Specifies the value of the Tax Area Code field.', Comment = '%';
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ToolTip = 'Specifies the value of the Tax Group Code field.', Comment = '%';
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ToolTip = 'Specifies the value of the Tax Liable field.', Comment = '%';
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ToolTip = 'Specifies the value of the Transaction No. field.', Comment = '%';
                }
                field("Use Tax"; Rec."Use Tax")
                {
                    ToolTip = 'Specifies the value of the Use Tax field.', Comment = '%';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ToolTip = 'Specifies the amount of VAT that is included in the total amount.';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the VAT specification of the involved item or resource to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                }
                field("VAT Reporting Date"; Rec."VAT Reporting Date")
                {
                    ToolTip = 'Specifies the VAT date on the VAT entry. This is either the date that the document was created or posted, depending on your setting on the General Ledger Setup page.';
                }
                field("Voucher Narration"; Rec."Voucher Narration")
                {
                    ToolTip = 'Specifies the value of the Voucher Narration field.', Comment = '%';
                }
            }
        }
    }
}
