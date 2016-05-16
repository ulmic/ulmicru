class RedirectRuleForm < ApplicationReform
  properties :status, :state, :old_path, :redirect_to, :reason
end
