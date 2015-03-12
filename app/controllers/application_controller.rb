require 'responders'

# Root controller from which all our controllers inherit.
class ApplicationController < ActionController::Base
  include Flip::ControllerFilters
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    instance_variable_set(
      model_instance_variable_name.pluralize,
      model_class.all,
    )
  end

  def new
    self.model_instance_variable = model_class.new
  end

  def create
    self.model_instance_variable = model_class.new(model_params)
    flash_success_message('created') if model_instance_variable.save

    respond
  end

  def destroy
    self.model_instance_variable = saved_model
    model_instance_variable.destroy
    flash_success_message('deleted') if model_instance_variable.destroy
    respond
  end

  def show
    self.model_instance_variable = saved_model
  end

  def edit
    self.model_instance_variable = saved_model
  end

  def update
    self.model_instance_variable = saved_model
    if model_instance_variable.update(model_params)
      flash_success_message('updated')
    end
    respond
  end

  # E.g. if update/create fails due to a validation error, Rails will render
  # the edit/new template. We want to know the actual template that was
  # rendered, so we can specify the correct JavaScript view.
  def render(*args, &block)
    @rendered_action = action_to_be_rendered(args.first)
    super
  end

  private

  def after_sign_out_path_for(_user)
    new_user_session_path
  end

  def model_instance_variable=(model_instance)
    instance_variable_set(model_instance_variable_name, model_instance)
  end

  def model_instance_variable
    instance_variable_get(model_instance_variable_name)
  end

  def model_instance_variable_name
    "@#{model_name.underscore}"
  end

  def saved_model
    model_class.find(params.require(:id))
  end

  def model_class
    @model_class ||= model_name.constantize
  end

  def model_name
    @model_name ||= self.class.name.demodulize.gsub(
      /Controller$/, ''
    ).singularize
  end

  def namespace
    @namespace ||= self.class.name.deconstantize.underscore
  end

  def respond
    respond_with(namespace, model_instance_variable) unless namespace.empty?
    respond_with(model_instance_variable) if namespace.empty?
  end

  def flash_success_message(action)
    message = "#{model_name.underscore.humanize} was successfully #{action}."
    flash[:notice] = message
  end

  def action_to_be_rendered(action_or_options)
    if action_or_options.is_a? Hash
      action_or_options.fetch(:action, nil)
    else
      action_or_options
    end
  end
end
