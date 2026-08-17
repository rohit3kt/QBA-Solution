pageextension 50118 "QBA Purchase Invoice" extends "Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(Vendor)
        {
            action(UpdateValue)
            {
                ApplicationArea = All;
                Caption = 'Update Value';
                Image = Refresh;
                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchaseHeader.Reset();
                    If PurchaseHeader.FindSet() then
                        repeat
                            UpdateAPIFields(PurchaseHeader."No.");
                        until PurchaseHeader.Next() = 0;
                end;
            }
        }
        addafter(Vendor_Promoted)
        {
            actionref(UpdateValue_Promoted; UpdateValue)
            {
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        UpdateAPIFields(Rec."No.");
    end;

    trigger OnOpenPage()
    begin
        UpdateAPIFields(Rec."No.");
    end;

    trigger OnClosePage()
    begin
        UpdateAPIFields(Rec."No.");
    end;

    local procedure UpdateAPIFields(DocumentNo: Code[20])
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", DocumentNo);
        if PurchaseLine.FindSet() then
            repeat
                if (PurchaseLine."GST Group Code" <> '') OR (PurchaseLine."HSN/SAC Code" <> '')
                        OR (PurchaseLine."GST Credit" <> PurchaseLine."GST Credit"::" ")
                        OR (PurchaseLine."Gen. Bus. Posting Group" <> '')
                        OR (PurchaseLine."Gen. Prod. Posting Group" <> '') then begin
                    PurchaseLine."API GST Group Code" := PurchaseLine."GST Group Code";
                    PurchaseLine."API HSN Code" := PurchaseLine."HSN/SAC Code";
                    PurchaseLine."API GST Credit" := PurchaseLine."GST Credit";
                    PurchaseLine."API Gen. Busines Posting Group" := PurchaseLine."Gen. Bus. Posting Group";
                    PurchaseLine."API Gen. Product Posting Group" := PurchaseLine."Gen. Prod. Posting Group";
                end;
            until PurchaseLine.Next() = 0;
    end;

    var
        myInt: Integer;
}