pageextension 50104 FixedAssetList extends "Fixed Asset List"
{
    layout
    {
        addafter(Acquired)
        {
            field(BookValue; BookValue)
            {
                ApplicationArea = all;
                Caption = 'Book Value';

                trigger OnDrillDown()
                begin
                    FADepreciationBook.DrillDownOnBookValue();
                end;
            }
        }
    }
    var recfixedasset: Record "Fixed Asset";
    fixedassetcard: Page "Fixed Asset Card";
    BookValue: Decimal;
    protected var FADepreciationBook: Record "FA Depreciation Book";
    FADepreciationBookOld: Record "FA Depreciation Book";
    Simple: Boolean;
    trigger OnAfterGetRecord()
    begin
        // Clear(BookValue);
        // recfixedasset.Reset();
        // recfixedasset.SetRange("No.", Rec."No.");
        // if recfixedasset.FindFirst() then;
        if rec."No." <> xRec."No." then SaveSimpleDepreciationBook(xRec."No.");
        LoadFADepreciationBooks();
        FADepreciationBook.Copy(FADepreciationBookOld);
        BookValue:=GetBookValue();
    end;
    local procedure GetBookValue(): Decimal begin
        if FADepreciationBook."Disposal Date" > 0D then exit(0);
        exit(FADepreciationBook."Book Value");
    end;
    procedure SaveSimpleDepreciationBook(FixedAssetNo: Code[20])
    begin
        if not SimpleFADepreciationBookHasChanged()then exit;
        if Simple then UpdateDepreciationBook(FixedAssetNo);
    end;
    protected procedure SimpleFADepreciationBookHasChanged(): Boolean begin
        exit(Format(FADepreciationBook) <> Format(FADepreciationBookOld));
    end;
    procedure UpdateDepreciationBook(FixedAssetNo: Code[20])
    var
        FixedAsset: Record "Fixed Asset";
        IsHandled: Boolean;
    begin
        IsHandled:=false;
        // OnBeforeUpdateDepreciationBook(IsHandled, FixedAssetNo, FADepreciationBook);
        if IsHandled then exit;
        if FixedAsset.Get(FixedAssetNo)then if FADepreciationBook."Depreciation Book Code" <> '' then if FADepreciationBook."FA No." = '' then begin
                    FADepreciationBook.Validate("FA No.", FixedAssetNo);
                    FADepreciationBook.Insert(true)end
                else
                begin
                    FADepreciationBook.Description:=Rec.Description;
                    FADepreciationBook.Modify(true);
                end;
    end;
    protected procedure LoadFADepreciationBooks()
    begin
        Clear(FADepreciationBookOld);
        FADepreciationBookOld.SetRange("FA No.", rec."No.");
        if FADepreciationBookOld.Count <= 1 then begin
            if FADepreciationBookOld.FindFirst()then begin
                FADepreciationBookOld.CalcFields("Book Value");
            //kallol  ShowAddMoreDeprBooksLbl := true
            end;
            Simple:=true;
        //kallol AllowEditDepBookCode := FADepreciationBookOld."Depreciation Book Code" = '';
        end
        else
            Simple:=false;
    //kallol OnAfterLoadDepreciationBooks(Rec, Simple);
    end;
}
