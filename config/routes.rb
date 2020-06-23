resources :projects do
  put :typologies_enumerations, :controller => 'project_typologies_enumerations', action: :update
end

