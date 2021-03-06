﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.Security;
using System.Data;
using System.Web.Script.Serialization;
using System.Threading;

public partial class libraries_aspx_PDFUpload : System.Web.UI.Page
{
    /// <summary>
    ///    Uploading file for source
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    //  SOURCE_FILE_DELETED
    // protected string MsgSourceDeleteConfirmation = string.Empty;
    protected string MsgErrorInUploadingFile = string.Empty;
    protected string MsgFileTypeAllowed = string.Empty;
    protected string MsgInvalidFileName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //MsgSourceDeleteConfirmation = DILanguage.GetLanguageString("SOURCE_FILE_DELETED");
            //this.hdnSourceDeletionMsgConf.Value = DILanguage.GetLanguageString("SOURCE_FILE_DELETED");
            string SourceName = string.Empty;
            string SourceNId = string.Empty;
            string FileName = string.Empty;
            string UniqueFileName = string.Empty;
            string FileExtension = string.Empty;
            string TempSourceFolderPath = string.Empty;
            string FileToBeSaved = string.Empty;
            string DateTimeString = string.Empty;

            if (Request.QueryString["Pdf"] != null)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["Pdf"].ToString()))
                {
                    string FileActualPath = Server.MapPath(Request.QueryString["Pdf"].ToString());
                    if (File.Exists(FileActualPath))
                    {
                        InvokeJsMethod("updateMsg", "UpdateParent", Path.GetFileName(Request.QueryString["Pdf"].ToString()), Request.QueryString["Pdf"].ToString());
                    }
                }

            }

            if (Request.Files.Count == 1)
            {

                FileExtension = Path.GetExtension(fileUploadPDF.PostedFile.FileName).ToLower();

                DateTimeString = DateTime.Now.ToString().Replace(":", "").Replace("/", "").Replace(" ", "").Replace("AM", "").Replace("PM", "");
                UniqueFileName = System.IO.Path.GetFileNameWithoutExtension(fileUploadPDF.PostedFile.FileName).Replace(" ", "") + "__" + DateTimeString + FileExtension;

                //'-- Check and create Source folder within Temp folder if it does not exists
                TempSourceFolderPath = Server.MapPath("diorg/pdfs/news");
                if (!Directory.Exists(TempSourceFolderPath))
                {
                    Directory.CreateDirectory(TempSourceFolderPath);
                }

                // '-- Check for prior existence of file with same name in Temp folder, and delete if found any
                FileToBeSaved = Server.MapPath("diorg/pdfs/news/" + UniqueFileName);
                if (File.Exists(FileToBeSaved))
                    File.Delete(FileToBeSaved);

                fileUploadPDF.PostedFile.SaveAs(Server.MapPath("diorg/pdfs/news/" + UniqueFileName));
                InvokeJsMethod("updateMsg", "UpdateParent", UniqueFileName, "diorg/pdfs/news/" + UniqueFileName);
            }
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    /// <summary>
    ///     
    /// </summary>
    private void InvokeJsMethod(string methodKey, string methodName, string argument, string filePath)
    {
        if (string.IsNullOrEmpty(argument) == false)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), methodKey, "javaScript:" + methodName + "('" + argument + "','" + filePath + "');", true);
        }
        else
        {

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), methodKey, "javaScript:" + methodName + "('" + filePath + "');", true);
        }
    }
}