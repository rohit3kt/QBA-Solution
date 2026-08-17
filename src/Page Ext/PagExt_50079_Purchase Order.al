pageextension 50079 PurchaseOrder extends "Purchase Order"
{
    layout
    {
        addafter("Promised Receipt Date") //"Bill to-Location(POS)"
        {
            field("Ship To"; Rec."Ship To")
            {
                ApplicationArea = all;
                Caption = 'Referance Ship To';
                Visible = true;
            }
            field("Customer Code_"; Rec."Customer Code_")
            {
                ApplicationArea = all;
            }
        }
        addbefore("Posting Date")
        {
            field("OrderDate"; Rec."Order Date")
            {
                ApplicationArea = all;
                Caption = 'Order Date';
            }
        }
        modify(ShippingOptionWithLocation)
        {
            trigger onaftervalidate()
            begin
                if ShipToOptions = ShipToOptions::Location then begin
                    Rec.Validate(Rec."Ship To", 'Location');
                    rec.Modify(true);
                end
                else if ShipToOptions = ShipToOptions::"Custom Address" then begin
                    Rec.Validate(Rec."Ship To", 'Custom Address');
                    rec.Modify(true);
                end
                else if ShipToOptions = ShipToOptions::"Customer Address" then begin
                    Rec.Validate(Rec."Ship To", 'Customer Address');
                    //  Rec.Validate(());
                    // rec."Sell-to Customer No."
                    rec.Modify(true);
                end
                else if ShipToOptions = ShipToOptions::"Default (Company Address)" then begin
                    Rec.Validate(Rec."Ship To", 'Default (Company Address)');
                    rec.Modify(true);
                end;
            end;
            //     trigger OnBeforeValidate()
            //     begin
            //         if ShipToOptions = ShipToOptions::Location then begin
            //             Rec.Validate(Rec."Ship To", 'Location');
            //             rec.Modify(true);
            //         end else
            //             if ShipToOptions = ShipToOptions::"Custom Address"
            //    then begin
            //                 Rec.Validate(Rec."Ship To", 'Custom Address');
            //                 rec.Modify(true);
            //             end else
            //                 if ShipToOptions = ShipToOptions::"Customer Address"
            //        then begin
            //                     Rec.Validate(Rec."Ship To", 'Customer Address');
            //                     rec.Modify(true);
            //                 end else
            //                     if ShipToOptions = ShipToOptions::"Default (Company Address)"
            //            then begin
            //                         Rec.Validate(Rec."Ship To", 'Default (Company Address)');
            //                         rec.Modify(true);
            //                     end;
            //     end;
        }
    }
    actions
    {
        addafter(Print)
        {
            action(Print_2)
            {
                Caption = 'Print_2';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                Image = Print;
                Visible = false;
                trigger OnAction()
                begin
                    recsalheader.Reset();
                    recsalheader.SetRange("No.", Rec."No.");
                    if recsalheader.FindFirst() then begin
                        Report.Run(50019, true, false, recsalheader);
                    end;
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        if ShipToOptions = ShipToOptions::Location then begin
            Rec.Validate(Rec."Ship To", 'Location');
            rec.Modify(true);
        end
        else if ShipToOptions = ShipToOptions::"Custom Address" then begin
            Rec.Validate(Rec."Ship To", 'Custom Address');
            rec.Modify(true);
        end
        else if ShipToOptions = ShipToOptions::"Customer Address" then begin
            Rec.Validate(Rec."Ship To", 'Customer Address');
            rec.Modify(true);
        end
        else if ShipToOptions = ShipToOptions::"Default (Company Address)" then begin
            Rec.Validate(Rec."Ship To", 'Default (Company Address)');
            rec.Modify(true);
        end;

        UpdateAPIFields(Rec."No.");
    end;

    trigger OnClosePage()
    begin
        UpdateAPIFields(Rec."No.");
    end;

    trigger OnOpenPage()
    begin
        UpdateAPIFields(Rec."No.");
    end;
    // trigger OnAfterGetCurrRecord()
    // begin
    //     if ShipToOptions = ShipToOptions::Location then
    //         Rec.Validate(Rec."Ship To", 'Location');
    //     //'Location';
    //     rec.Modify(true);
    //     CurrPage.Update(true);
    // end;
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
        recsalheader: Record 38;
}
