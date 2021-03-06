using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using DevInfo.Lib.DI_LibDAL.Queries.DIColumns;
using DevInfo.Lib.DI_LibBAL.Utility;
using DevInfo.Lib.DI_LibDAL.Queries;
namespace DevInfo.Lib.DI_LibBAL.Controls.ListViewBAL
{
    class ICListViewSource : BaseListViewSource
    {
        #region "-- Protected --"

        #region "-- Variables --"

        #endregion

        #region "-- Methods --"

        protected override string GetAllRecordsSqlQuery(string searchString)
        {
            string RetVal = string.Empty;
            string FilterString = string.Empty;

            //if (!string.IsNullOrEmpty(searchString))
            //{

            //    FilterString = " '%" + searchString + "%' ";
            //    RetVal = this.DBQueries.IndicatorClassification.GetIC(FilterFieldType.Search, FilterString, this.ClassificationType, FieldSelection.Light);
            //}
            //else
            //{
            RetVal = this.DBQueries.IndicatorClassification.GetIC(FilterFieldType.ParentNId, "-1", this.ClassificationType, FieldSelection.Light);
            //}


            return RetVal;
        }

        protected override string GetRecordsByNIDsSqlQuery(string availableNids)
        {
            string RetVal = string.Empty;

            //if (!string.IsNullOrEmpty(availableNids))
            //{

            //    RetVal = this.DBQueries.IndicatorClassification.GetIC(FilterFieldType.NId, availableNids, ICType.Source, FieldSelection.Light);
            //}
            //else
            //{
            RetVal = this.DBQueries.IndicatorClassification.GetIC(FilterFieldType.ParentNId, "-1", this.ClassificationType, FieldSelection.Light);
            //}

            return RetVal;
        }

        protected override string GetAutoSelectRecordsSqlQuery()
        {
            string RetVal = string.Empty;

            RetVal = this.DBQueries.Source.GetAutoSelectSource(this.DIUserPreference.UserSelection.IndicatorNIds, this.DIUserPreference.UserSelection.ShowIUS,
                this.DIUserPreference.UserSelection.AreaNIds,
                this.DIUserPreference.UserSelection.TimePeriodNIds);

            return RetVal;
        }

        #endregion

        #endregion

        #region "-- Intenal --"

        #region "-- Methods --"

        internal override void SetColumnInfo()
        {
            string CurrentClassificationType=string.Empty;

            this._Columns.Clear();

            CurrentClassificationType = DIQueries.ICTypeText[this.ClassificationType];

            //set columns info
            //this._Columns.Add(new ColumnInfo(IndicatorClassifications.ICName, DILanguage.GetLanguageString("SOURCE"), string.Empty));
            this._Columns.Add(new ColumnInfo(IndicatorClassifications.ICName, CurrentClassificationType, string.Empty));

            //set tag value column
            this._TagValueColumnName = IndicatorClassifications.ICNId;
        }

        #endregion

        #endregion

        #region "- Public --"

        #region "-- Methods --"

        /// <summary>
        /// Retruns IndicatorNids from userpreference
        /// </summary>
        /// <returns></returns>
        public override string GetSelectedNids()
        {
            return this.DIUserPreference.UserSelection.SourceNIds;
        }

        #endregion

        #endregion
    }
}
