<div class="modal" id="storagebrowse" tabindex="-1" role="dialog" aria-labelledby="storagebrowsetitle"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="storagebrowsetitle">Select a Storage File</h4>
            </div>

            <div class="modal-body" style="max-height: 500px; overflow-y: scroll">
                <g:render template="storageBrowser"/>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-sm btn-success obs-storagebrowse-select"
                        data-bind="css: selectedPath()?'active':'disabled' "
                        data-dismiss="modal">
                    Choose Selected File
                </button>
            </div>
        </div>
    </div>
</div>
<script lang="text/javascript">
    jQuery(function(){
        jQuery('#storagebrowse').on('show.bs.modal',function (evt) {
            var rootPath = jQuery(evt.relatedTarget).data('storage-root');
            if (!rootPath.startsWith("keys/")) {
                rootPath = "keys";
            }
            var storageBrowse = jQuery(evt.delegateTarget).data('storageBrowser');
            var storageBrowseTarget = jQuery(evt.relatedTarget).data('field');
            if (storageBrowse == null) {
                storageBrowse= new StorageBrowser(appLinks.storageKeysApi, rootPath);

                jQuery('body').data('storageBrowser', storageBrowse );
                jQuery(evt.delegateTarget).data('storageBrowser', storageBrowse);
                ko.applyBindings(storageBrowse);
            }
            storageBrowse.fieldTarget(storageBrowseTarget);
        }).on('shown.bs.modal', function (evt) {
            var storageBrowseTarget = jQuery(evt.relatedTarget).data('field');
            var filter = jQuery(evt.relatedTarget).data('storage-filter');
            var selectedPath = jQuery(storageBrowseTarget).val();
            var storageBrowse = jQuery(evt.delegateTarget).data('storageBrowser');
            storageBrowse.browse(null, filter, selectedPath);
        });
    });
</script>
