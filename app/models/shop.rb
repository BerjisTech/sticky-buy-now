class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  validates :mobile_z_index, length: { maximum: 5, message: "Mobile z-index must be less than or equal to 99999." }, numericality: { only_integer: true,allow_nil: true }
  validates :desktop_z_index, length: { maximum: 5, message: "Desktop z-index must be less than or equal to 99999." }, numericality: { only_integer: true,allow_nil: true }
  validates :desktop_padding_left, length: { maximum: 5, message: "Desktop padding left must be less than or equal to 99999." }, numericality: { only_integer: true,allow_nil: true }
  validates :desktop_padding_right, length: { maximum: 5, message: "Desktop padding right must be less than or equal to 99999." }, numericality: { only_integer: true,allow_nil: true }
  validates :desktop_position_offset, length: { maximum: 5, message: "Desktop position offset must be less than or equal to 99999." }, numericality: { only_integer: true,allow_nil: true }
  validates :mobile_position_offset, length: { maximum: 5, message: "Mobile position offset must be less than or equal to 99999." }, numericality: { only_integer: true,allow_nil: true }

  def api_version
    ShopifyApp.configuration.api_version
  end
end