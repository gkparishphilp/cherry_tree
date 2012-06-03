collection @active_assignments
attributes :id, :point_value
node(:description) { |active_assignment| active_assignment.objective.name }