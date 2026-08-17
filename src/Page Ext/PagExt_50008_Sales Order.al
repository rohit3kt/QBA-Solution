pageextension 50008 SalesOrder extends "Sales Order"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field(PostingNoSeries; Rec."Posting No. Series")
            {
                ApplicationArea = all;
                Caption = 'Posting No. Series';
            }
        }
        addafter("Applies-to Doc. No.")
        {
            field("Ship To"; Rec."Ship To")
            {
                ApplicationArea = all;
                Caption = 'Referance Ship To';
                Visible = true;
            }
        }
        modify(ShippingOptions)
        {
            trigger onaftervalidate()
            begin
                if ShipToOptions = ShipToOptions::"Alternate Shipping Address" then begin
                    Rec.Validate(Rec."Ship To", 'Alternate Shipping Address');
                    rec.Modify(true);
                end
                else if ShipToOptions = ShipToOptions::"Default (Sell-to Address)" then begin
                    Rec.Validate(Rec."Ship To", 'Default (Sell-to Address)');
                    rec.Modify(true);
                end
                else if ShipToOptions = ShipToOptions::"Custom Address" then begin
                    Rec.Validate(Rec."Ship To", 'Custom Address');
                    rec.Modify(true);
                end
            end;
        }
    }
    actions
    {
        addafter("&Print")
        {
            action(Print2)
            {
                Caption = 'Print Proforma Invoice';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    SalesHeader_G.reset;
                    SalesHeader_G.SetRange("No.", Rec."No.");
                    if SalesHeader_G.FindFirst() then
                        Report.Run(50028, true, false, SalesHeader_G);
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        if ShipToOptions = ShipToOptions::"Alternate Shipping Address" then begin
            Rec.Validate(Rec."Ship To", 'Alternate Shipping Address');
            rec.Modify(true);
        end
        else if ShipToOptions = ShipToOptions::"Default (Sell-to Address)" then begin
            Rec.Validate(Rec."Ship To", 'Default (Sell-to Address)');
            rec.Modify(true);
        end;
    end;

    var
        SalesHeader_G: Record "Sales Header";
}
