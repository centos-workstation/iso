help:
	@echo -- HeliumOS ISO --
	@echo Requires: lorax
	@echo make fetch - Fetch upstream iso
	@echo make patch - Patch upstream iso to produce final iso
	@echo make create - Fetch if needed, then patch
fetch:
	rm -f upstream.iso
	curl -o upstream.iso -J -L https://download.cf.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-boot.iso
patch:
	rm -f new.iso
	rm -rdf images && mkdir images
	cd product && find . | cpio -c -o | gzip -9cv > ../product.img
	mv product.img images/product.img
	mkksiso --add images --add isolinux --add EFI --volid heliumos-boot --ks heliumos.ks upstream.iso new.iso
	mv new.iso HeliumOS-9-latest-x86_64-boot.iso	
create:
	if [ -e upstream.iso ] ; then echo "Upstream iso present" ; else make fetch ; fi
	make patch
