pageextension 50000 "ADM PageExt50000" extends "Item Card"
{

    layout
    {
        addlast(content)
        {
            group(NutritionalInfos)
            {
                Caption = 'Nutritional Infos';
                field("total calories"; "total calories")
                {
                    ApplicationArea = All;
                    Caption = 'total calories';

                    trigger OnAssistEdit()
                    var
                        ADMNutrition: Record "ADM Nutritional Information";
                        ADMNutritionalInfoPage: Page "ADM Nutritional Informations";
                        TotCal: Decimal;
                        locitem: Record item;
                        prova: Decimal;
                        result: Decimal;
                    begin
                        if not Confirm('Do you want to recalculate the total calories for item %1 ?', false, Rec."No.") then
                            ADMNutrition.Reset();
                        ADMNutrition.SetRange("Item No.", Rec."No.");

                        if ADMNutrition.FindSet() then
                            repeat
                                TotCal += ADMNutrition.Amount;
                            until ADMNutrition.Next() = 0;

                        prova := Rec."Net Weight" * "total calories";
                        result := prova / 100;
                        Rec."total calories" := result;
                        // locitem.Get("No.");

                        Rec.Modify();
                        exit;
                    end;

                }
            }
        }

        addfirst(factboxes)
        {
            part("ADM Nutr. Info Factbox"; "ADM Nutr. Info Factbox")
            {
                Caption = 'Nutritional Infos';
                ApplicationArea = all;
                SubPageLink = "Item No." = field("No.");
            }
        }
    }


    actions
    {

        addlast(navigation)
        {

            group(NutritionalInfo)
            {
                Caption = 'Item Nutritional Infos';
                action(Nutritionals)
                {
                    ApplicationArea = All;
                    Caption = 'Show Nutritional Infos';
                    //Promoted = true;
                    //PromotedCategory = Process;
                    //PromotedIsBig = true;
                    Image = RelatedInformation;
                    trigger OnAction()
                    var
                        ADMNutritionalInfo: Record "ADM Nutritional Information";
                        ADMNutritionalInfoPage: Page "ADM Nutritional Informations";
                        TotCal: Decimal;
                        locitem: Record item;
                    begin

                        ADMNutritionalInfo.SetRange("Item No.", "No.");
                        ADMNutritionalInfoPage.SetTableView(ADMNutritionalInfo);
                        ADMNutritionalInfoPage.RunModal();

                        TotCal := 0;
                        ADMNutritionalInfo.Reset();
                        ADMNutritionalInfo.SetRange("Item No.", "No.");
                        if ADMNutritionalInfo.FindSet() then
                            repeat
                                TotCal += ADMNutritionalInfo.Amount;
                            until ADMNutritionalInfo.Next() = 0;

                        locitem.Get("No.");
                        locitem."total calories" := TotCal;
                        locitem.Modify();


                    end;
                }

            }

        }
    }
}

