pageextension 50112 "QBA Update Referenc Invoice No" extends "Update Reference Invoice No"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(Verify)
        {
            action("UpdateRefNo")
            {
                ApplicationArea = All;
                Caption = 'Update Ref No.';
                Image = Process;
                Ellipsis = true;
                trigger OnAction()
                var
                    InputBox: Page "Input Box";
                    ReferenceInvoiceNo: Record "Reference Invoice No.";
                begin
                    if Rec."Document No." <> '' then begin
                        InputBox.LookupMode := true;
                        if InputBox.RunModal() <> Action::LookupOK then
                            Error('Process has been aborted!');
                        Rec."Reference Invoice Nos." := InputBox.GetCodeComment();
                        Rec.Insert();
                    end;
                end;
            }
            action(QBAVerify)
            {
                ApplicationArea = All;
                Caption = 'QBA Verify';
                Image = Process;
                Ellipsis = true;
                trigger OnAction()
                var
                    InputBox: Page "Input Box";
                    ReferenceInvoiceNo: Record "Reference Invoice No.";
                begin
                    ReferenceInvoiceNo.SetRange("Document No.", Rec."Document No.");
                    ReferenceInvoiceNo.SetRange("Document Type", Rec."Document Type");
                    ReferenceInvoiceNo.SetRange("Source No.", Rec."Source No.");
                    if ReferenceInvoiceNo.FindFirst() then begin
                        ReferenceInvoiceNo.Verified := true;
                        ReferenceInvoiceNo.Modify();
                    end;
                end;
            }
        }
        addafter(Verify_Promoted)
        {
            actionRef(UpdateRefNo_Promoted; UpdateRefNo) { }
            actionRef(QBAVerify_Promoted; QBAVerify) { }
        }
    }

    var
        myInt: Integer;
}