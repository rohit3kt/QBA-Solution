page 50103 "Selected Lines Total"
{
    PageType = CardPart;
    Editable = false;
    SourceTable = "Total Selection Lines";
    layout
    {
        area(Content)
        {
            field(LinesConut; Rec.LinesConut)
            {
                Caption = 'Count';
                ApplicationArea = All;
            }
            field(LinesAverage; Rec.LinesAverage)
            {
                Caption = 'Average';
                ApplicationArea = All;
                Visible = false;
            }
            field(Amount; Rec.Amount)
            {
                Caption = 'Total Amount';
                ApplicationArea = All;
            }
            field(Quantity; Rec.Quantity)
            {
                Caption = 'Total Quantity';
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
    procedure SetTotals(var NewCount: Integer; NewAverage: Decimal; NewTotalAmount: Decimal; NewTotalQuantity: Decimal)
    begin
        Rec.Reset();
        Rec.DeleteAll();
        Rec.Init();
        Rec.Number := 1;
        Rec.LinesConut := NewCount;
        Rec.LinesAverage := NewAverage;
        Rec.Amount := NewTotalAmount;
        Rec.Quantity := NewTotalQuantity;
        Rec.Insert();
    end;

    // procedure QBA_Amount(VendLedger: Record "Vendor Ledger Entry"; QBAAmount: Decimal)
    // var
    //     RecTotalSelectionLines: Record "Total Selection Lines";
    // begin
    //     if not RecTotalSelectionLines.Get(1) then begin
    //         RecTotalSelectionLines.Init();
    //         RecTotalSelectionLines.Number := 1;
    //         RecTotalSelectionLines.LinesConut := 1;
    //         RecTotalSelectionLines.Amount := QBAAmount;
    //         RecTotalSelectionLines.Insert();
    //     end else begin
    //         if RecTotalSelectionLines.LinesConut > VendLedger.Count then begin
    //             RecTotalSelectionLines.Reset();
    //             RecTotalSelectionLines.DeleteAll();
    //             RecTotalSelectionLines.Init();
    //             RecTotalSelectionLines.Number := 1;
    //             RecTotalSelectionLines.LinesConut := 1;
    //             RecTotalSelectionLines.Amount := QBAAmount;
    //             RecTotalSelectionLines.Insert();
    //         end;
    //         RecTotalSelectionLines.LinesConut += 1;
    //         RecTotalSelectionLines.Amount += QBAAmount;
    //         RecTotalSelectionLines.Modify();
    //     end;
    //     Rec := RecTotalSelectionLines;
    //     CurrPage.Update();
    // end;
}