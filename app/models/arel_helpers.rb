class ArelHelpers
  def self.quoted(str)
    Arel::Nodes.build_quoted(str)
  end

  def self.to_timestamp(expr)
    if expr.is_a?(Date) || expr.is_a?(DateTime) || expr.is_a?(Time)
      Arel::Nodes::NamedFunction.new('TO_TIMESTAMP', [expr.to_i])
    else
      Arel::Nodes::NamedFunction.new('TO_TIMESTAMP', [expr])
    end
  end

  def self.date_part(part, expr)
    part = ArelHelpers::quoted(part) if part.is_a?(String)
    Arel::Nodes::NamedFunction.new('DATE_PART', [part, expr])
  end

  def self.abs(expr)
    Arel::Nodes::NamedFunction.new('ABS', [expr])
  end
end
