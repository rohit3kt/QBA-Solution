tableextension 50031 PurchaseLine extends "Purchase Line"
{
    fields
    {
        field(50000; "cgst amt"; Decimal)
        {
            Caption = 'cgst amt';
            DataClassification = ToBeClassified;
        }
        field(50001; "sgst amt"; Decimal)
        {
            Caption = 'sgst amt';
            DataClassification = ToBeClassified;
        }
        field(50002; "IGST Amt"; Decimal)
        {
            Caption = 'Igst amt';
            DataClassification = ToBeClassified;
        }
        field(50003; "IGST per"; Decimal)
        {
            Caption = 'IGST Per';
            DataClassification = ToBeClassified;
        }
        field(50004; "CGST per"; Decimal)
        {
            Caption = 'CGST Per';
            DataClassification = ToBeClassified;
        }
        field(50005; "SGST per"; Decimal)
        {
            Caption = 'SGST Per';
            DataClassification = ToBeClassified;
        }
        field(50006; Remark; Text[250])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }
        modify("HSN/SAC Code")
        {
            trigger OnAfterValidate()
            var
                RecPurchaseHeader: Record "Purchase Header";
                GSTGroup: Record "GST Group";
            begin
                if Rec."GST Group Code" <> '' then
                    GStGroup.Get(Rec."GST Group Code");
                if RecPurchaseHeader.Get(RecPurchaseHeader."Document Type"::Order, Rec."Document No.") then begin
                    if ((RecPurchaseHeader."GST Vendor Type" = RecPurchaseHeader."GST Vendor Type"::Unregistered) AND (Not GSTGroup."Reverse Charge")) then
                        Rec."GST Group Code" := '';
                end;
            end;

        }
        field(60000; "API HSN Code"; Code[20])
        {
            Caption = 'HSN Code';
            TableRelation = "HSN/SAC".Code where("GST Group Code" = field("API GST Group Code"));
        }
        field(60001; "API GST Group Code"; Code[20])
        {
            Caption = 'GST Group Code';
            TableRelation = "GST Group";
        }
        field(60002; "API GST Credit"; Enum "GST Credit")
        {
            Caption = 'GST Credit';
        }
        field(60003; "API Gen. Busines Posting Group"; Code[20])
        {
            Caption = 'Gen. Business Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(60004; "API Gen. Product Posting Group"; Code[20])
        {
            Caption = 'Gen. Product Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
    }
    trigger OnBeforeInsert()
    begin
        if Rec."API GST Group Code" <> '' then begin
            Rec."GST Group Code" := Rec."API GST Group Code";
            Rec."HSN/SAC Code" := Rec."API HSN Code";
            Rec."GST Credit" := Rec."API GST Credit";
            Rec."Gen. Bus. Posting Group" := Rec."API Gen. Busines Posting Group";
            Rec."Gen. Prod. Posting Group" := Rec."API Gen. Product Posting Group";
        end;
    end;

    trigger OnBeforeModify()
    begin
        if Rec."API GST Group Code" <> '' then begin
            Rec."GST Group Code" := Rec."API GST Group Code";
            Rec."HSN/SAC Code" := Rec."API HSN Code";
            Rec."GST Credit" := Rec."API GST Credit";
            Rec."Gen. Bus. Posting Group" := Rec."API Gen. Busines Posting Group";
            Rec."Gen. Prod. Posting Group" := Rec."API Gen. Product Posting Group";
        end;
    end;
}
