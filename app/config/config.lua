return {
	users = {
	    {
	        username = "test",
	        password = "test"
	    },
	    {
	        username = "sumory",
	        password = "1"
	    }
	},

	whitelist = {
		"/",
		"/view",
		"/auth/login", -- login page
		"/error/" -- error page
	},

	-- 安全加密相关
	security = {
		session_aes_key = 'nWiUMp4gO6cvYsSs',
		session_aes_secret = 'q6TGzXdus9gjjRRJ'
	}
}
