report 50012 UpdateDepBook
{
    ApplicationArea = All;
    Caption = 'Update Dep Book';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(FALedgerEntry; "FA Ledger Entry")
        {
            trigger OnPreDataItem()
            begin
            // QBACOMP00001
            //  FALedgerEntry.SetFilter("FA No.", '=%1', 'QBACOMP00001');//start date 23-09-2023
            end;
            trigger OnAfterGetRecord()
            begin
                RecFADEpBook.Reset();
                RecFADEpBook.SetRange("FA No.", FALedgerEntry."FA No.");
                FALedgerEntry.SetRange("FA Posting Type", "FA Posting Type"::"Acquisition Cost");
                if RecFADEpBook.FindFirst()then begin
                    RecFADEpBook."Depreciation Starting Date":=FALedgerEntry."FA Posting Date";
                    RecFADEpBook.Modify(true);
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var RecFADEpBook: Record 5612;
}
