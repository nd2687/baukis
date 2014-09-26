class StaffEventPresenter < ModelPresenter
  delegate :member, :description, :occurred_at, to: :object

  def table_raw
    markup(:tr) do |m|
      unless view_context.instance_variable_get(:@staff_member)
        m.td do
          m << link_to(member.family_name + member.given_name,
            [ :admin, member, :staff_events ])
        end
      end
    end
  end
end
