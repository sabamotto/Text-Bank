class Chapter < ApplicationRecord
  validates :title, :author, presence: true

  def raise_order(num=1)
    self.order_to order_id - (num || 1)
  end

  def lower_order(num=1)
    self.order_to order_id + (num || 1)
  end

  def order_to(target_order_id)
    raise 'illegal raising scale' unless target_order_id.is_a? Integer

    target_order_id = target_order_id.clamp(1, Chapter.count)
    return self if order_id == target_order_id

    direction = (target_order_id > order_id)? 1 : -1

    transaction do
      # ユニーク制約を回避するため一時的に0にする
      original_order_id = order_id
      self.order_id = 0
      self.save!

      Chapter.select(:id, :order_id).lock
      .where(order_id: (original_order_id+direction)..target_order_id)
      .find_each do |shift_chapter|
        shift_chapter.update_column :order_id, shift_chapter.order_id - direction
      end

      self.order_id = target_order_id
      self.save!
    end

    self
  # rescue => e
  #   logger.warn "  #{e.message} in Chapter#raise_order"
  #   nil
  end
end
