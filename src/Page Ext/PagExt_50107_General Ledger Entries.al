pageextension 50107 GeneralLedgerEntries extends "General Ledger Entries"
{
    layout
    {
        addafter("Entry No.")
        {
            field(Comment; Rec.Comment)
            {
                ApplicationArea = all;
                Caption = 'Remarks';
            }
            field("Line Narration"; Rec."Line Narration")
            {
                ApplicationArea = all;
            }
            field("Voucher Narration"; Rec."Voucher Narration")
            {
                ApplicationArea = all;
            }
        }
        addafter(Amount)
        {
            field("CreditAmount"; Rec."Credit Amount")
            {
                Caption = 'Credit Amount';
                ApplicationArea = all;
            }
            field("DebitAmount"; Rec."Debit Amount")
            {
                Caption = 'Debit Amount';
                ApplicationArea = all;
            }
        }
        addafter("Source No.")
        {
            field(SourceName; SourceName)
            {
                ApplicationArea = All;
                Caption = 'Source Name';
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        recnarrationVoucher.Reset();
        recnarrationVoucher.SetRange("Document No.", Rec."Document No.");
        if recnarrationVoucher.FindFirst() then
            rec."Voucher Narration" := recnarrationVoucher.Narration;
        //
        recnarrationLine.Reset();
        recnarrationLine.SetRange("Document No.", rec."Document No.");
        if recnarrationLine.FindFirst() then
            rec."Line Narration" := recnarrationLine.Narration;

        Clear(SourceName);
        if Rec."Source Type" = Rec."Source Type"::Customer then begin
            if Customer.Get(Rec."Source No.") then
                SourceName := Customer.Name;
        end;
        if Rec."Source Type" = Rec."Source Type"::Vendor then begin
            if Vendor.Get(Rec."Source No.") then
                SourceName := Vendor.Name;
        end;
    end;

    var
        recnarrationVoucher: Record "Posted Narration";
        recnarrationLine: Record "Posted Narration";
        SourceName: Text[100];
        Vendor: Record Vendor;
        Customer: Record Customer;
        dad: Report 6;
}
