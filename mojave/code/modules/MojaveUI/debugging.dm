/client/verb/showStorageUI()
	set category = "OOC"
	set name = "storage"

	var/obj/mojaveUI/storage/ui = new
	ui.rows = 3
	ui.cols = 3
	ui.Show(usr.client)


/client/verb/ShowGeneratorUI()
	set category = "OOC"
	set name = "generator"

	var/obj/mojaveUI/generator/ui = new
	ui.Show(usr.client)
