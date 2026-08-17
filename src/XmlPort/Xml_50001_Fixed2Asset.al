xmlport 50001 Fixed2Asset
{
    Caption = 'Fixed2Asset';

    schema
    {
    textelement(RootNodeName)
    {
    tableelement(FixedAsset;
    "Fixed Asset")
    {
    fieldelement(Acquired;
    FixedAsset.Acquired)
    {
    }
    fieldelement(AddDeprApplicable;
    FixedAsset."Add. Depr. Applicable")
    {
    }
    fieldelement(Blocked;
    FixedAsset.Blocked)
    {
    }
    fieldelement(BudgetedAsset;
    FixedAsset."Budgeted Asset")
    {
    }
    fieldelement(Comment;
    FixedAsset.Comment)
    {
    }
    fieldelement(ComponentofMainAsset;
    FixedAsset."Component of Main Asset")
    {
    }
    fieldelement(Description;
    FixedAsset.Description)
    {
    }
    fieldelement(Description2;
    FixedAsset."Description 2")
    {
    }
    fieldelement(Exempted;
    FixedAsset.Exempted)
    {
    }
    fieldelement(FABlockCode;
    FixedAsset."FA Block Code")
    {
    }
    fieldelement(FAClassCode;
    FixedAsset."FA Class Code")
    {
    }
    fieldelement(FALocationCode;
    FixedAsset."FA Location Code")
    {
    }
    fieldelement(FAPostingGroup;
    FixedAsset."FA Posting Group")
    {
    }
    fieldelement(FASubclassCode;
    FixedAsset."FA Subclass Code")
    {
    }
    fieldelement(GSTCredit;
    FixedAsset."GST Credit")
    {
    }
    fieldelement(GSTGroupCode;
    FixedAsset."GST Group Code")
    {
    }
    fieldelement(GenProdPostingGroup;
    FixedAsset."Gen. Prod. Posting Group")
    {
    }
    fieldelement(GlobalDimension1Code;
    FixedAsset."Global Dimension 1 Code")
    {
    }
    fieldelement(GlobalDimension2Code;
    FixedAsset."Global Dimension 2 Code")
    {
    }
    fieldelement(HSNSACCode;
    FixedAsset."HSN/SAC Code")
    {
    }
    fieldelement(Image;
    FixedAsset.Image)
    {
    }
    fieldelement(Inactive;
    FixedAsset.Inactive)
    {
    }
    fieldelement(Insured;
    FixedAsset.Insured)
    {
    }
    fieldelement(LastDateModified;
    FixedAsset."Last Date Modified")
    {
    }
    fieldelement(LocationCode;
    FixedAsset."Location Code")
    {
    }
    fieldelement(MainAssetComponent;
    FixedAsset."Main Asset/Component")
    {
    }
    fieldelement(MaintenanceVendorNo;
    FixedAsset."Maintenance Vendor No.")
    {
    }
    fieldelement(NextServiceDate;
    FixedAsset."Next Service Date")
    {
    }
    fieldelement(No;
    FixedAsset."No.")
    {
    }
    fieldelement(NoSeries;
    FixedAsset."No. Series")
    {
    }
    fieldelement(ResponsibleEmployee;
    FixedAsset."Responsible Employee")
    {
    }
    fieldelement(SearchDescription;
    FixedAsset."Search Description")
    {
    }
    fieldelement(SerialNo;
    FixedAsset."Serial No.")
    {
    }
    fieldelement(SystemCreatedAt;
    FixedAsset.SystemCreatedAt)
    {
    }
    fieldelement(SystemCreatedBy;
    FixedAsset.SystemCreatedBy)
    {
    }
    fieldelement(SystemId;
    FixedAsset.SystemId)
    {
    }
    fieldelement(SystemModifiedAt;
    FixedAsset.SystemModifiedAt)
    {
    }
    fieldelement(SystemModifiedBy;
    FixedAsset.SystemModifiedBy)
    {
    }
    fieldelement(TaxGroupCode;
    FixedAsset."Tax Group Code")
    {
    }
    fieldelement(UnderMaintenance;
    FixedAsset."Under Maintenance")
    {
    }
    fieldelement(VATProductPostingGroup;
    FixedAsset."VAT Product Posting Group")
    {
    }
    fieldelement(VendorNo;
    FixedAsset."Vendor No.")
    {
    }
    fieldelement(WarrantyDate;
    FixedAsset."Warranty Date")
    {
    }
    }
    }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
