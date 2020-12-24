document.addEventListener('turbolinks:load', () => {
  const productFormDOM = document.getElementById('product-form');
  if( !productFormDOM ){ return false; }

  // valiables
  const MAX_IMAGES_COUNT     = 5;
  const newLabel             = document.getElementById('new-label');
  const imageFileFieldsBox   = document.getElementById('image-file-fields');

  // HTML of new input file field
  const newFileField = (index) => {
    return `<input accept="image/*" class="new-product-image" type="file" name="product[images_attributes][${index}][src]" id="product_images_attributes_${index}_src">`;
  }

  // HTML of Preview
  const previewHTML = (blobUrl,index) => {
    return `
      <label class="image__default" data-index="${index}" for="product_images_attributes_${index}_src">
        <img src="${blobUrl}">
        <i class="far fa-times-circle"></i>
        <div class="edit-image">Replacement image</div>
      </label>
    `;
  }

  // ============ delete preview and input file ============
  const deleteAction = (index) => {
    const newPreviewDOM = document.querySelector(`.image__default[data-index="${index}"]`);
    const deleteBtnDOM  = newPreviewDOM.querySelector(`i`);

    deleteBtnDOM.addEventListener('click', ()=>{
      // remove preview
      const previewDOM = document.querySelector(`.image__default[data-index="${index}"]`);
      previewDOM.remove();
  
      // remove input file field
      const fileField = document.querySelector(`#product_images_attributes_${index}_src`);
      fileField.remove();
  
      // if the number of preview is 1 less than the MAX_IMAGES_COUNT, display new file field.
      const imageCount = document.querySelectorAll(`.image__default`).length;
      if ( imageCount == MAX_IMAGES_COUNT - 1 ){
        // display new file field.
        newLabel.style.display = 'flex';
      }

      // update checkbox
      const checkBoxDOM = document.querySelector(`#product_images_attributes_${index}__destroy`);
      if ( checkBoxDOM ){ checkBoxDOM.checked = true; }
    });
  }

  // ============ When file selected, insert preview and new input file field ============
  const insertPreviewAndInput = (e) => {
    const file            = e.target.files[0];
    const blobUrl         = window.URL.createObjectURL(file);
    const index           = Number(e.target.id.match(/\d/)[0]);

    const defaultPreviewDOM = document.querySelector(`.image__default[data-index="${index}"]`);
    if ( defaultPreviewDOM ){
      defaultPreviewDOM.querySelector('img').src = blobUrl;
    }else{

      // insert preview
      newLabel.insertAdjacentHTML('beforebegin', previewHTML(blobUrl,index));
      // update attribute for of label
      newLabel.setAttribute('for',`product_images_attributes_${index + 1}_src`)
      // set delete event
      deleteAction(index);
      
      const imageCount = document.querySelectorAll(`.image__default`).length;
      if (imageCount < MAX_IMAGES_COUNT){
        // insert input file field
        imageFileFieldsBox.insertAdjacentHTML('beforeend', newFileField(index + 1));

        // set event for new input file field
        const newFileFieldDOM = document.querySelector(`#product_images_attributes_${index + 1}_src`);
        newFileFieldDOM.addEventListener( 'change' , (e)=>{ insertPreviewAndInput(e); });
        
      }else{
        // hidden new file field.
        newLabel.style.display = 'none';
      }
    }
  }

  // set delete event for default preview.
  const defaultPreviewDOMs = document.querySelectorAll(`.image__default`);
  defaultPreviewDOMs.forEach( (defaultPreview, index)=> { deleteAction(index); });
  if ( defaultPreviewDOMs.length == MAX_IMAGES_COUNT ){ newLabel.style.display = 'none'; }

  // set insert event for default input file field
  const defaultFileFieldDOMs = document.querySelectorAll('[class^=file_field_]');
  defaultFileFieldDOMs.forEach( (defaultFileFieldDOM) => { 
    defaultFileFieldDOM.addEventListener('change', (e) => { insertPreviewAndInput(e); });
  });
  
});