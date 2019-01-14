ActiveAdmin.register Question do
	config.paginate = false
	config.sort_order = 'korder_asc'
	controller do
		def orderup
			q = Question.find(params[:id])
			q1 = Question.all(:order=>"korder desc", :conditions=>"korder < #{q.korder}").first
			if q1!=nil
				q_order = q.korder
				q1_order = q1.korder
				q.korder = q1_order
				q1.korder = q_order
				q.save
				q1.save
			end
			redirect_to :back
		end
		def orderdown
			q = Question.find(params[:id])
			q1 = Question.all(:order=>"korder asc", :conditions=>"korder > #{q.korder}").first
			if q1!=nil
				q_order = q.korder
				q1_order = q1.korder
				q.korder = q1_order
				q1.korder = q_order
				q.save
				q1.save
			end
			redirect_to :back
		end
	end
	
  index do
    column :id, :sortable=>false
    column :question do |q|
			s = q.answers_text
			raw "<pre style='white-space: pre-line;'>#{q.question} (#{q.trait})\n</pre>"+
				"<pre>#{s}</pre>"
		end
    column :answer_type, :sortable=>false
    column :qgroup do |q|
			q.group_text
		end
		column "Order", :korder do |order|
			s = link_to("Up", question_order_up_path(order))+ " " +
			link_to("Down", question_order_down_path(order))
			raw "#{s}"
		end
    default_actions
  end
	
	show do |q|
		attributes_table do
			row :question do
				raw "<pre>#{q.question}</pre>"+
					"<pre>#{q.answers_text}</pre>"
			end
			row :trait
			row :qgroup do
				q.group_text
			end
			row :answer_type
		end
	end
		
  form do |f|
    f.inputs do
      f.input :question, :required=>true
			f.input :answer_type, :as=>:select, :collection=>Question::ANSWER_TYPE, :required=>true
			f.input :trait, :required=>true, :input_html=>{:style=>"width: 100px;"}
			f.input :qgroup, :as=>:select, :collection=>Question::QUESTION_GROUP, :required=>true
    end
		
		
    f.buttons
  end
	
end
