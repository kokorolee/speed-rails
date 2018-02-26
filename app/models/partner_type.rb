class PartnerType < ApplicationRecord
  enumerize :status, in: {active: 1, not_active: 2}
end
