class FundingRequest < ApplicationRecord
  belongs_to :round
  belongs_to :construction
  has_many :fund_request_responses, dependent: :destroy
  has_many :funding_request_player_roles, dependent: :destroy
  has_many :funding_request_resources, dependent: :destroy

  def unique_funder_for_turn(funder)
    request_type=self.construction.construction_type
    self.round.funding_requests&.each do |fund_request|
      if fund_request.funder == funder && fund_request.construction.construction_type==request_type
        return false
      end
    end
    true
  end
  
  def owner
    @owner=nil
    self.funding_request_player_roles.each do |role|
      if role.player_role == "owner"
        @owner=role.player
      end
    end
    @owner
  end

  def funder 
    @funder=self.funding_request_player_roles.find_by(player_role:"funder")&.player || nil
  end

  def is_not_accepted
    @is_not_accepted=true
    self.fund_request_responses&.each do |response|
      if response.funding_request_response_type == "accept"
        @is_not_accepted=false
      end
    end
    @is_not_accepted
  end

  def is_accepted
    @is_accepted=false
    self.fund_request_responses&.each do |response|
      if response.funding_request_response_type == "accept"
        @is_accepted=true
      end
    end
    @is_accepted
  end

  def is_not_rejected
    @is_not_rejected=true
    self.fund_request_responses&.each do |response|
      if response.funding_request_response_type == "reject"
        @is_not_rejected=false
      end
    end
    @is_not_rejected
  end
  
  def unresponded_to?
    @unresponded_to=true
    self.fund_request_responses&.each do |response|
      @unresponded_to=false
    end
    @unresponded_to
  end
end
