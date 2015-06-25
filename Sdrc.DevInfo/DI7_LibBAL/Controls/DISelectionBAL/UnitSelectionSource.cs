using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using DevInfo.Lib.DI_LibBAL.Controls.DISelectionBAL;
using DevInfo.Lib.DI_LibDAL.Queries;
using DevInfo.Lib.DI_LibBAL.Utility;
using DevInfo.Lib.DI_LibBAL.UI.AutoSelect;
using DevInfo.Lib.DI_LibDAL.Queries.DIColumns;
using DevInfo.Lib.DI_LibBAL.UI.UserPreference;

//using DevInfo.Lib.DI_LibBAL.Controls.TreeSelectionBAL;

namespace DevInfo.Lib.DI_LibBAL.Controls.DISelectionBAL
{
    /// <summary>
    /// Helps in getting unit records for DISelectionControl
    /// </summary>
    public class UnitSelectionSource : BaseSelection
    {
  
        #region "-- Protected --"

        #region "-- Methods --"

        internal protected override  DataView processDataView(DataView dv)
        {
            // do nothing 
            return dv;
        }

        protected override void SetColumnNames()
        {
            this._TagValueColumnName = Unit.UnitNId;
            this._GlobalValueColumnName1 = Unit.UnitGlobal ;
            this._FirstColumnName = Unit.UnitName;
        }

        protected override void SetColumnHeaders()
        {
            ////Get header string from language file and set column headers string 
            this._FirstColumnHeader = DILanguage.GetLanguageString("UNIT");
            
        }

        protected override string GetAssocicatedRecordsQuery(int selectedNid, int selectedParentNid)
        {
            // Dont implement and delete this method
            return string.Empty;
        }

        protected override string GetSelectAllQuery()
        {
            string RetVal = string.Empty;
                      
            RetVal = this.SqlQueries.Unit.GetUnit(FilterFieldType.None, string.Empty);
           
            return RetVal;

        }

        protected override string GetRecordsForSelectedNids(string nids)
        {
            string RetVal = string.Empty;

            RetVal = this.SqlQueries.Unit.GetUnit(FilterFieldType.NId, nids);

            return RetVal;
        }

        protected override string GetAssocicatedRecordsQuery(string selectedNids)
        {
            //Do nothing
            return string.Empty;
        }

        public override void UpdataDataTableBeforeCreatingListviewItem(DataTable iuTable)
        {
            //-- Do Nothing
        }

        public override List<string> GetIUSNIds(string iuNIds, bool checkUserSelection, bool selectSingleTon)
        {
            return new List<string>();
        }

        #endregion

        #endregion

        #region "-- Public --"

        #region "-- Methods --"

        public override DataTable GetAutoSelectRecordsForAvailableList(string availableItemsNid)
        {
            // dont implement and delete this method
            return null;
        }

        /// <summary>
        /// Returns records for  auto select option of treeview.
        /// </summary>
        /// <returns></returns>
        public override DataTable GetAllRecordsForTreeAutoSelect()
        {
            // dont implement and delete this method
            return null;

        }

        /// <summary>
        /// Returns all records 
        /// </summary>
        /// <returns></returns>
        public override DataTable GetAllRecordsTable()
        {
            DataTable RetVal=null;
            try
            {
                RetVal = this._DBConnection.ExecuteDataTable(this.GetSelectAllQuery());
            }
            catch (Exception ex)
            {
                // do nothing
            }
            return RetVal;
        }

        public override List<string> GetSubgroupDimensions(string iuNId, string IUSNIds)
        {
            return new List<string>();
        }

        public override List<string> GetSubgroupDimensionsWithIU(string iuNId, string IUSNIds)
        {
            return new List<string>();
        }

        public override void UpdateIndicatorSelectedDetails(int indicatorNId, int unitNId, string selectionDetails, bool addNewSelection)
        {
            //Do nothing
        }

        public override string GetIndicatorSelectionDetails(int indicatorNId, int unitNId)
        {
            return string.Empty;
        }


        #endregion

        #endregion

    }
}
