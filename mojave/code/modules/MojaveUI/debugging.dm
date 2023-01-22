/client/verb/showStorageUI()
	set category = "OOC"
	set name = "storage"

	var/obj/mojaveUI/storage/ui = new
	ui.rows = 1
	ui.cols = 1
	ui.Show(usr.client)
