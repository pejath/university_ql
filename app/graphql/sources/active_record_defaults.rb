# frozen_string_literal: true

module Sources
  # Workaround for objects that have policies that require related records to be preloaded.
  class ActiveRecordDefaults
    STRICT_LOADING_DEFAULT = true

    # DEFAULT_OPTIONS_BY_MODEL = {
    #   ::RequestItem => { preload: [:request] },
    #
    #   # Activity rendering happens outside of GraphQL so it can't use batch loading.
    #   # This interim solution preloads all the relations that the activity renderer needs
    #   # *and* disabled strict loading since activities can have custom rendering procs that
    #   # try to lazy-load additional relations e.g. `activity.trackable.request.subject`
    #   ::Activity => {
    #     preload: [:actor, :trackable, :event_subject],
    #     strict_loading: false,
    #   },
    # }

    class << self
      def options_for(model_class, overrides = {})
        {}.merge(overrides)
      end

      def apply_to(scope_or_model_class, overrides = {})
        scope = if scope_or_model_class.is_a?(::ActiveRecord::Relation)
                  scope_or_model_class
                else
                  scope_or_model_class.default_scoped
                end

        opts = options_for(scope.model, overrides)

        if (preload = opts[:preload])
          scope = scope.preload(preload)
        end

        if opts.fetch(:strict_loading, STRICT_LOADING_DEFAULT)
          scope = scope.strict_loading
        end

        scope
      end
    end
  end
end
