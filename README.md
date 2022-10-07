# Samples for the PDF Services Java SDK Using CFML

> Based on the official Java sample project by Adobe found [here](https://github.com/adobe/pdfservices-java-sdk-samples).

This sample project helps you get started with the PDF Services Java SDK for use with Adobe's Document Services API.

The sample ColdFusion Components illustrate how to perform PDF-related actions (such as converting to and from the PDF format) using the SDK. **Please note that the PDF Services Java SDK supports only server side use cases.**

## Prerequisites
The sample application has the following requirements:
* Java JDK: Version 8 or above.
* A CFML Engine: Adobe ColdFusion 2016+ (default) or Lucee 5+, as either a standalone install or via [CommandBox (recommended)](https://www.ortussolutions.com/products/commandbox).

## Authentication Setup

The credentials file and corresponding private key file for the samples is `pdfservices-api-credentials.json` and `private.key`
respectively. Before the samples can be run, replace both the files with the ones present in the downloaded zip file at
the end of creation of credentials via [Get Started](https://www.adobe.io/apis/documentcloud/dcsdk/gettingstarted.html?ref=getStartedWithServicesSdk) workflow.

The SDK also supports providing the authentication credentials at runtime, without storing them in a config file. Please
refer this [section](#create-a-pdf-file-from-a-docx-file-by-providing-in-memory-authentication-credentials) to
know more.

## Client Configurations

The SDK supports setting up custom socket timeout or connect timeout for the API calls. Please
refer this [section](#create-a-pdf-file-from-a-docx-file-by-providing-custom-value-for-timeouts) to
know more.

The SDK also supports setting up Proxy Server configurations which helps in successful API calls for network where all outgoing calls have to go through a proxy else, they are blocked. Please
refer this [section](#create-a-pdf-file-from-a-docx-file-by-providing-proxy-server-settings) to
know more.

## Quota Exhaustion

If you receive ServiceUsageException during the Samples run, it means that trial credentials have exhausted their quota
of 5000 pages. Contact [Adobe](https://www.adobe.com/go/pdftoolsapi_requestform) to get paid credentials.

## Build JAR Dependencies With Maven

Maven must be installed in order to properly pull in the JAR dependencies. Maven installation instructions can be found [here](https://maven.apache.org/install.html).

Run the following command to build the project dependencies into a usable JAR and placed into the /lib directory:
```$xslt
mvn clean install
```

> Note: The PDF Services SDK is listed as a dependency in the pom.xml and will be downloaded automatically. The project JAR is already built with the necessary dependencies and included in the project for use. If you need to re-build the project dependencies, you may run the build process described above.

## Java API Documentation

Javadocs for the current and previous versions of the PDF Services library can be obtained from the [official Java sample project](https://github.com/adobe/pdfservices-java-sdk-samples/tree/master/docs).

## A Note On Logging

Unlike the Java samples which use the [slf4j API](https://www.slf4j.org/) with a log4j2-slf4j binding, logging in the example CFCs is handled through the native CFML `writeLog()` function. To avoid any classpath conflicts, the pom.xml excludes the slf4j API JAR dependency.

## Running the Samples

To execute the samples, you will need to run the project from a local installation of a ColdFusion server or stand up a server instance on the fly via [CommandBox](https://www.ortussolutions.com/products/commandbox).

To start a server using CommandBox, run `box start` in your terminal while pointing to the project working directory. The server will start on port `8520` and be available in the browser at `http://127.0.0.1:8520`. Note that by default the server will start using the latest version of `Adobe ColdFusion 2021`. To use a different version/engine, update the `cfengine` in `server.json`.

The following sub-sections describe how to run the samples. Prior to running the samples, check that the configuration
file is set up as described above and that the project has been built.

The code itself is in the `components` folder. The CFCs are executed in the browser via CFM pages found in `samples`. Test files used by the CFCs can be found in `resources`. When executed, all samples create an `output` folder under the working directory to store their results.

### Create a PDF File

These samples illustrate how to convert files of some formats to PDF.

#### Create a PDF File From a DOCX File

The sample CFC CreatePDFFromDOCX creates a PDF file from a DOCX file.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=createpdf.CreatePDFFromDOCX
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=createpdf.CreatePDFFromDOCX
```

####  Create a PDF File From a DOCX File With Options

The sample CFC CreatePDFFromDOCXWithOptions creates a PDF file from a DOCX file by setting documentLanguage as
the language of input file.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=createpdf.CreatePDFFromDOCXWithOptions
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=createpdf.CreatePDFFromDOCXWithOptions
```

#### Create a PDF File From a DOCX Input Stream

The sample CFC CreatePDFFromDOCXInputStream creates a PDF file from a DOCX input stream.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=createpdf.CreatePDFFromDOCXInputStream
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=createpdf.CreatePDFFromDOCXInputStream
```

#### Create a PDF File From a DOCX File (Write to an OutputStream)

The sample CFC CreatePDFFromDOCXToOutputStream creates a PDF file from a DOCX file. Instead of saving the result to a local file, it writes the result to an output stream.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=createpdf.CreatePDFFromDOCXToOutputStream
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=createpdf.CreatePDFFromDOCXToOutputStream
```

#### Create a PDF File From a PPTX File

The sample CFC CreatePDFFromPPTX creates a PDF file from a PPTX file.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=createpdf.CreatePDFFromPPTX
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=createpdf.CreatePDFFromPPTX
```

#### Create a PDF File From Static HTML (via Zip Archive)

The sample CFC CreatePDFFromStaticHTML creates a PDF file from a zip file containing the input HTML file and its resources.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=createpdf.CreatePDFFromStaticHTML
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=createpdf.CreatePDFFromStaticHTML
```

#### Create a PDF File From Static HTML file with inline CSS

The sample CFC CreatePDFFromHTMLWithInlineCSS creates a PDF file from an input HTML file with inline CSS.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=createpdf.CreatePDFFromHTMLWithInlineCSS
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=createpdf.CreatePDFFromHTMLWithInlineCSS
```

#### Create a PDF File From HTML specified via URL

The sample CFC CreatePDFFromURL creates a PDF file rom an HTML specified via URL.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=createpdf.CreatePDFFromURL
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=createpdf.CreatePDFFromURL
```

#### Create a PDF File From Dynamic HTML (via Zip Archive)

The sample CFC CreatePDFFromDynamicHTML converts a zip file, containing the input HTML file and its resources, along with the input data to a PDF file. The input data is used by the JavaScript in the HTML file to manipulate the HTML DOM, thus effectively updating the source HTML file. This mechanism can be used to provide data to the template HTML dynamically and then, convert it into a PDF file.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=createpdf.CreatePDFFromDynamicHTML
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=createpdf.CreatePDFFromDynamicHTML
```

#### Create a PDF File From a DOCX File (By providing in-memory Authentication credentials)

The sample CFC `CreatePDFWithInMemoryAuthCredentials` highlights how to provide in-memory auth credentials for performing an operation. This enables the clients to fetch the credentials from a secret server during runtime, instead of storing them in a file.

Before running the sample, authentication credentials need to be updated as per the instructions in the CFC.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=createpdf.CreatePDFWithInMemoryAuthCredentials
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=createpdf.CreatePDFWithInMemoryAuthCredentials
```

#### Create a PDF File From a DOCX File (By providing custom value for timeouts)

The sample project CreatePDFWithCustomTimeouts highlights how to provide the custom value for connection timeout and socket timeout.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=createpdf.CreatePDFWithCustomTimeouts
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=createpdf.CreatePDFWithCustomTimeouts
```

#### Create a PDF File From a DOCX File (By providing Proxy Server settings)

The sample project CreatePDFWithPorxyServer highlights how to provide Proxy Server configurations to allow all API calls via that proxy Server.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=createpdf.CreatePDFWithProxyServer
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=createpdf.CreatePDFWithProxyServer
```

### Export PDF To Other Formats
These samples illustrate how to export PDF files to other formats.

#### Export a PDF File To a DOCX File

The sample CFC ExportPDFToDOCX converts a PDF file to a DOCX file.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=exportpdf.ExportPDFToDOCX
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=exportpdf.ExportPDFToDOCX
```
#### Export a PDF file to a DOCX file (apply OCR on the PDF file)

The sample CFC ExportPDFToDOCXWithOCROption converts a PDF file to a DOCX file. OCR processing is also performed on the input PDF file to extract text from images in the document.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=exportpdf.ExportPDFToDOCXWithOCROption
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=exportpdf.ExportPDFToDOCXWithOCROption
```
#### Export a PDF File To an Image Format (JPEG)

The sample CFC ExportPDFToJPEG converts a PDF file's pages to a list of JPEG images.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=exportpdftoimages.ExportPDFToJPEG
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=exportpdftoimages.ExportPDFToJPEG
```

#### Export a PDF File To a Zip of Images (JPEG)

The sample CFC ExportPDFToJPEGZip converts a PDF file's pages to JPEG images. The resulting file is a ZIP archive containing one image per page of the source PDF file.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=exportpdftoimages.ExportPDFToJPEGZip
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=exportpdftoimages.ExportPDFToJPEGZip
```

### Combine PDF Files
These samples illustrate how to combine multiple PDF files into a single PDF file.

#### Combine Multiple PDF Files

The sample CFC CombinePDF combines multiple PDF files into a single PDF file. The combined PDF file contains all pages of the source files.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=combinepdf.CombinePDF
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=combinepdf.CombinePDF
```

#### Combine Specific Pages of Multiple PDF Files

The sample CFC CombinePDFWithPageRanges combines specific pages of multiple PDF files into into a single PDF file.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=combinepdf.CombinePDFWithPageRanges
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=combinepdf.CombinePDFWithPageRanges
```

### OCR PDF File

These samples illustrate how to apply OCR(Optical Character Recognition) to a PDF file and convert it to a searchable copy of your PDF. The supported input format is application/pdf.

#### Convert a PDF File into a Searchable PDF File

The sample CFC OcrPDF converts a PDF file into a searchable PDF file.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=ocrpdf.OcrPDF
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=ocrpdf.OcrPDF
```

#### Convert a PDF File into a Searchable PDF File while keeping the original image

The sample CFC OcrPDFWithOptions converts a PDF file to a searchable PDF file with maximum fidelity to the original image and default en-us locale. Refer to the documentation of OCRSupportedLocale and OCRSupportedType to see the list of supported OCR locales and OCR types.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=ocrpdf.OcrPDFWithOptions
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=ocrpdf.OcrPDFWithOptions
```

### Compress PDF File

These samples illustrate how to reduce the size of a PDF file.

#### Reduce PDF File Size

The sample CFC CompressPDF reduces the size of a PDF file.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=compresspdf.CompressPDF
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=compresspdf.CompressPDF
```

####  Reduce PDF File Size On the Basis of Compression Level

The sample CFC CompressPDFWithOptions reduces the size of a PDF file on the basis of provided compression level.
Refer to the documentation of CompressionLevel to see the list of supported compression levels.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=compresspdf.CompressPDFWithOptions
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=compresspdf.CompressPDFWithOptions
```

### Linearize PDF File

The sample illustrates how to convert a PDF file into a Linearized (also known as "web optimized") PDF file. Such PDF files are
optimized for incremental access in network environments.

#### Convert a PDF File into a Web Optimized File

The sample CFC LinearizePDF optimizes the PDF file for a faster Web View.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=linearizepdf.LinearizePDF
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=linearizepdf.LinearizePDF
```

### Protect PDF File

The sample illustrates how to secure a PDF file with a password.

#### Convert a PDF File into a Password Protected PDF File

The sample CFC ProtectPDF converts a PDF file into a password protected PDF file.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=protectpdf.ProtectPDF
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=protectpdf.ProtectPDF
```

#### Protect a PDF File with an Owner Password and Permissions

The sample CFC ProtectPDFWithOwnerPassword secures an input PDF file with owner password and allows certain access permissions
such as copying and editing the contents, and printing of the document at low resolution.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=protectpdf.ProtectPDFWithOwnerPassword
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=protectpdf.ProtectPDFWithOwnerPassword
```

### Remove Protection

The sample illustrates how to remove a password security from a PDF document.

#### Remove Protection from a PDF File

The sample CFC RemoveProtection removes a password security from a secured PDF document.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=removeprotection.RemoveProtection
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=removeprotection.RemoveProtection
```

### Rotate Pages

The sample illustrates how to rotate pages in a PDF file.

#### Rotate Pages in PDF File

The sample CFC RotatePDFPages rotates specific pages in a PDF file.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=rotatepages.RotatePDFPages
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=rotatepages.RotatePDFPages
```

### Delete Pages

The sample illustrates how to delete pages in a PDF file.

#### Delete Pages from PDF File

The sample CFC DeletePDFPages removes specific pages from a PDF file.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=deletepages.DeletePDFPages
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=deletepages.DeletePDFPages
```

### Reorder Pages

The sample illustrates how to reorder the pages in a PDF file.

#### Reorder Pages in PDF File

The sample CFC ReorderPDFPages rearranges the pages of a PDF file according to the specified order.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=reorderpages.ReorderPDFPages
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=reorderpages.ReorderPDFPages
```

### Insert Pages

The sample illustrates how to insert pages in a PDF file.

#### Insert Pages into a PDF File

The sample CFC InsertPDFPages inserts pages of multiple PDF files into a base PDF file.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=insertpages.InsertPDFPages
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=insertpages.InsertPDFPages
```

### Replace Pages

The sample illustrates how to replace pages of a PDF file.

#### Replace PDF File Pages with Multiple PDF Files

The sample CFC ReplacePDFPages replaces specific pages in a PDF file with pages from multiple PDF files.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=replacepages.ReplacePDFPages
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=replacepages.ReplacePDFPages
```

### Split PDF File

These samples illustrate how to split PDF file into multiple PDF files.

#### Split PDF By Number of Pages

The sample CFC SplitPDFByNumberOfPages splits input PDF into multiple PDF files on the basis of the maximum number of pages each of the output files can have.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=splitpdf.SplitPDFByNumberOfPages
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=splitpdf.SplitPDFByNumberOfPages
```

#### Split PDF Into Number of PDF Files

The sample CFC SplitPDFIntoNumberOfFiles splits input PDF into multiple PDF files on the basis of the number of documents.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=splitpdf.SplitPDFIntoNumberOfFiles
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=splitpdf.SplitPDFIntoNumberOfFiles
```

#### Split PDF By Page Ranges

The sample CFC SplitPDFByPageRanges splits input PDF into multiple PDF files on the basis of page ranges. Each page range corresponds to a single output file having the pages specified in the page range.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=splitpdf.SplitPDFByPageRanges
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=splitpdf.SplitPDFByPageRanges
```

### Document Merge

Adobe Document Merge Operation allows you to produce high fidelity PDF and Word documents with dynamic data inputs. Using this operation, you can merge your JSON data with Word templates to create dynamic documents for contracts and agreements, invoices, proposals, reports, forms, branded marketing documents and more.

To know more about document generation and document templates, please checkout the [documentation](http://www.adobe.com/go/dcdocgen_overview_doc)

#### Merge Document to DOCX with Fragments

The sample CFC MergeDocumentToDOCX merges the Word based document template with the input JSON data and fragments JSON to generate
the output document in the DOCX format.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=documentmerge.MergeDocumentToDOCXWithFragments
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=documentmerge.MergeDocumentToDOCXWithFragments
```

#### Merge Document to DOCX

The sample CFC MergeDocumentToDOCX merges the Word based document template with the input JSON data to generate
the output document in the DOCX format.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=documentmerge.MergeDocumentToDOCX
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=documentmerge.MergeDocumentToDOCX
```

#### Merge Document to PDF

The sample CFC MergeDocumentToPDF merges the Word based document template with the input JSON data to generate
the output document in the PDF format.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=documentmerge.MergeDocumentToPDF
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=documentmerge.MergeDocumentToPDF
```

### Extract PDF

These samples illustrate extracting content of PDF in a structured JSON format along with the renditions inside PDF. The output of SDK extract operation is Zip package. The Zip package consists of following:

* The structuredData.json file with the extracted content & PDF element structure. See the [JSON schema](https://opensource.adobe.com/pdftools-sdk-docs/release/shared/extractJSONOutputSchema.json). Please refer the [Styling JSON schema](https://opensource.adobe.com/pdftools-sdk-docs/release/shared/extractJSONOutputSchemaStylingInfo.json) for a description of the output when the styling option is enabled.
* A renditions folder(s) containing renditions for each element type selected as input. The folder name is either "tables" or "figures" depending on your specified element type. Each folder contains renditions with filenames that correspond to the element information in the JSON file.

#### Extract Text Elements

The sample CFC ExtractTextInfoFromPDF.cfc extracts text elements from PDF document.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=extractpdf.ExtractTextInfoFromPDF
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=extractpdf.ExtractTextInfoFromPDF
```

#### Extract Text, Table Elements

The sample CFC ExtractTextTableInfoFromPDF extracts text, table elements from PDF document.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=extractpdf.ExtractTextTableInfoFromPDF
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=extractpdf.ExtractTextTableInfoFromPDF
```

#### Extract Text, Table Elements with Renditions of Table Elements

The sample CFC ExtractTextTableInfoWithRenditionsFromPDF extracts text, table elements along with table renditions from PDF document. Note that the output is a zip containing the structured information along with renditions as described in [section](#extract-pdf).

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=extractpdf.ExtractTextTableInfoWithRenditionsFromPDF
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=extractpdf.ExtractTextTableInfoWithRenditionsFromPDF
```

#### Extract Text, Table Elements with Renditions of Figure, Table Elements

The sample CFC ExtractTextTableInfoWithFiguresTablesRenditionsFromPDF extracts text, table elements along with figure and table element's renditions from PDF document. Note that the output is a zip containing the structured information along with renditions as described in [section](#extract-pdf).

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=extractpdf.ExtractTextTableInfoWithFiguresTablesRenditionsFromPDF
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=extractpdf.ExtractTextTableInfoWithFiguresTablesRenditionsFromPDF
```

#### Extract Text Elements and bounding boxes for Characters present in text blocks

The sample CFC ExtractTextInfoWithCharBoundsFromPDF extracts text elements and bounding boxes for characters present in text blocks. Note that the output is a zip containing the structured information along with renditions as described in [section](#extract-pdf).

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=extractpdf.ExtractTextInfoWithCharBoundsFromPDF
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=extractpdf.ExtractTextInfoWithCharBoundsFromPDF
```

#### Extract Text, Table Elements and bounding boxes for Characters present in text blocks with Renditions of Table Elements

The sample CFC ExtractTextTableInfoWithCharBoundsFromPDF extracts text, table elements, bounding boxes for characters present in text blocks and table element's renditions from PDF document. Note that the output is a zip containing the structured information along with renditions as described in [section](#extract-pdf).

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=extractpdf.ExtractTextTableInfoWithCharBoundsFromPDF
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=extractpdf.ExtractTextTableInfoWithCharBoundsFromPDF
```

#### Extract Text, Table Elements with Renditions and CSV's of Table Elements

The sample CFC ExtractTextTableInfoWithTableStructureFromPdf extracts text, table elements, table structures as CSV and
table element's renditions from PDF document. Note that the output is a zip containing the structured information
along with renditions as described in [section](#extract-pdf).

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=extractpdf.ExtractTextTableInfoWithTableStructureFromPdf
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=extractpdf.ExtractTextTableInfoWithTableStructureFromPdf
```

#### Extract Text, Table Elements with Styling information of text

The sample CFC ExtractTextTableInfoWithStylingFromPDF extracts text and table elements along with the styling information of the text blocks.
Note that the output is a zip containing the structured information
along with renditions as described in [section](#extract-pdf).

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=extractpdf.ExtractTextTableInfoWithStylingFromPDF
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=extractpdf.ExtractTextTableInfoWithStylingFromPDF
```

### PDF Properties

This sample illustrates how to fetch properties of a PDF file.

#### Fetch PDF Properties

The sample CFC GetPDFProperties fetches the properties of an input PDF.

Browser:
```html
http://127.0.0.1:8520/components/proxy.cfc?method=run&cfcPath=pdfproperties.GetPDFProperties
```

CommandBox:
```$xslt
box task run taskFile=Exec :cfcPath=pdfproperties.GetPDFProperties
```

### Licensing

This project is licensed under the MIT License to stay in compliance with the official Java sample project from Adobe. See [LICENSE](LICENSE) for more information.

> Each sample CFC in this project was based on the original classes in the official Java project created by Adobe. All credit goes to the original creators/contributors. Thank you!
