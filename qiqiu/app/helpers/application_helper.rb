module ApplicationHelper
    private
        def uptoken
            put_policy = Qiniu::Auth::PutPolicy.new(
                'jie-trancender',
                nil,
                1800,
                (Time.now + 38.minutes).to_i
            )
            
            uptoken = Qiniu::Auth.generate_uptoken(put_policy)
        end
end
