pageextension 50116 "Posted Sales Credit Memos" extends "Posted Sales Credit Memos"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Navigate")
        {
            action(ExportExcel)
            {
                Caption = 'Export Excell';
                ApplicationArea = All;
                Image = ExportToExcel;
                RunObject = Report "Export Sal Cr Memo Into Excel";
            }
            action(ImportIRN)
            {
                ApplicationArea = All;
                Caption = 'Import IRN';
                Image = ImportExcel;
                Ellipsis = true;
                trigger OnAction()
                var
                    // LineNo: Integer;
                    // LengthCove: Integer;
                    // InputBox: Page "Input Box";
                    // InputValue: Date;
                    // SalesInvHeader: Record "Sales Invoice Header";
                    // GlEntry: Record "G/L Entry";
                    QBA_CU: Codeunit "QBA Event Subscriber";
                // RecRef: RecordRef;
                begin
                    QBA_CU.ReadExcelSheet();
                    QBA_CU.ImportIRNDataIntoCrMemo();
                end;
            }
        }
        addafter("&Navigate_Promoted")
        {
            actionref("ExportExcel_Promoted"; ExportExcel)
            {
            }
            actionref("ImportIRN_Promoted"; ImportIRN)
            {
            }
        }

    }

    var
        myInt: Integer;
}