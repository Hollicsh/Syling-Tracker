-- ========================================================================= --
--                              SylingTracker                                --
--           https://www.curseforge.com/wow/addons/sylingtracker             --
--                                                                           --
--                               Repository:                                 --
--                   https://github.com/Skamer/SylingTracker                 --
--                                                                           --
-- ========================================================================= --
Syling             "SylingTracker.Contents.ProfessionRecipesContentView"     ""
-- ========================================================================= --
__UIElement__()
class "ProfessionRecipesContentView"(function(_ENV)
  inherit "ContentView"
  -----------------------------------------------------------------------------
  --                                Methods                                  --
  -----------------------------------------------------------------------------
  function OnViewUpdate(self, data, metadata)
    super.OnViewUpdate(self, data, metadata)

    if data and (data.recipes or data.recraftRecipes) then
      local recipes 
      if data.recipes and data.recraftRecipes then
        recipes = {}
        for recipeID, recipeData in pairs(data.recraftRecipes) do 
          recipes[-recipeID] = recipeData
        end

        for recipeID, recipeData in pairs(data.recipes) do 
          recipes[recipeID] = recipeData
        end
      else
        recipes = data.recipes or data.recraftRecipes 
      end

      Style[self].Recipes.visible = self.Expanded
      local recipesListView = self:GetPropertyChild("Recipes")
      recipesListView:UpdateView(recipes, metadata) 
    else
      Style[self].Recipes = NIL
    end
  end


  function OnExpand(self)
    if self:GetPropertyChild("Recipes") then
      Style[self].Recipes.visible = true 
    end
  end

  function OnCollapse(self)
    if self:GetPropertyChild("Recipes") then 
      Style[self].Recipes.visible = false 
    end
  end
end)

__ChildProperty__(ProfessionRecipesContentView, "Recipes")
__UIElement__() class(tostring(ProfessionRecipesContentView) .. ".Recipes") { ProfessionRecipeListView }
-------------------------------------------------------------------------------
--                                Styles                                     --
-------------------------------------------------------------------------------
Style.UpdateSkin("Default", {
  [ProfessionRecipesContentView] = {
    [ProfessionRecipesContentView.Recipes] = {
      location = {
        Anchor("TOP", 0, -10, "Header", "BOTTOM"),
        Anchor("LEFT"),
        Anchor("RIGHT")
      }
    }
  }
})