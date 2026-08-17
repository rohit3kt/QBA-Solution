xmlport 50000 "Fixed Asset Xml"
{
    Caption = 'Fixed asset Xml';
    Direction = Both;
    UseRequestPage = true;
    Format = VariableText;

    // FieldDelimiter = '"';
    //FieldSeparator = ';';
    //  applicationarea =true;
    schema
    {
    textelement(RootNodeName)
    {
    // XmlName = 'GenLine';
    tableelement(FixedAsset;
    "Fixed Asset")
    {
    // XmlName = 'GenLine';
    fieldelement(test;
    FixedAsset."No.")
    {
    }
    fieldelement(description;
    FixedAsset.Description)
    {
    }
    fieldelement(desc2;
    FixedAsset."Description 2")
    {
    }
    fieldelement(faclasscode;
    FixedAsset."FA Class Code")
    {
    }
    fieldelement(fasubclasscode;
    FixedAsset."FA Subclass Code")
    {
    }
    fieldelement(dim1;
    FixedAsset."Global Dimension 1 Code")
    {
    }
    fieldelement(loc;
    FixedAsset."Location Code")
    {
    }
    fieldelement(faloc;
    FixedAsset."FA Location Code")
    {
    }
    fieldelement(serial;
    FixedAsset."Serial No.")
    {
    }
    fieldelement(fapos;
    FixedAsset."FA Posting Group")
    {
    }
    // fieldelement(depmet;FixedAsset.dep)
    //fieldelement(depstartdate;FixedAsset.dep)
    fieldelement(gppg;
    FixedAsset."Gen. Prod. Posting Group")
    {
    }
    fieldelement(fablockcode;
    FixedAsset."FA Block Code")
    {
    }
    }
    }
    }
}
