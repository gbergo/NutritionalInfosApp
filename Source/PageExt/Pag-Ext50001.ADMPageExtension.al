pageextension 50001 "ADM Page Extension" extends "Item List"
{

    layout
    {

    }

    actions
    {
        addlast(processing)
        {
            action("Total calories")
            {
                Caption = 'Total calories';
                ApplicationArea = All;
                Image = NewSum;
                ToolTip = 'Show the sum of the item for every item';

                trigger OnAction()
                var
                    TotalCalories: Decimal;
                    Item: Record Item;
                begin
                    if Item.CalcSums("total calories") then begin
                        TotalCalories := Rec."total calories";
                        Message('The sum of calories for every item is %1 ', TotalCalories);
                    end;

                end;
            }
        }
    }
    var
        myInt: Integer;
}
