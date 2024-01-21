package com.umrah.dto;

public class FilterRequest {
	
	private String filterId;
	
	private Integer filterStartPriceStatus;
	
	private Float filterStartPriceValue;
	
	private Integer filterEndPriceStatus;
	
	private Float filterEndPriceValue;
	
	private Integer filterSeasonStatus;
	
	private String filterSeasonValue;
	
	private Integer filterDurationStatus;
	
	private String filterDurationValue;

	public String getFilterId() {
		return filterId;
	}

	public void setFilterId(String filterId) {
		this.filterId = filterId;
	}

	public Integer getFilterStartPriceStatus() {
		return filterStartPriceStatus;
	}

	public void setFilterStartPriceStatus(Integer filterStartPriceStatus) {
		this.filterStartPriceStatus = filterStartPriceStatus;
	}

	public Float getFilterStartPriceValue() {
		return filterStartPriceValue;
	}

	public void setFilterStartPriceValue(Float filterStartPriceValue) {
		this.filterStartPriceValue = filterStartPriceValue;
	}

	public Integer getFilterEndPriceStatus() {
		return filterEndPriceStatus;
	}

	public void setFilterEndPriceStatus(Integer filterEndPriceStatus) {
		this.filterEndPriceStatus = filterEndPriceStatus;
	}

	public Float getFilterEndPriceValue() {
		return filterEndPriceValue;
	}

	public void setFilterEndPriceValue(Float filterEndPriceValue) {
		this.filterEndPriceValue = filterEndPriceValue;
	}

	public Integer getFilterSeasonStatus() {
		return filterSeasonStatus;
	}

	public void setFilterSeasonStatus(Integer filterSeasonStatus) {
		this.filterSeasonStatus = filterSeasonStatus;
	}

	public String getFilterSeasonValue() {
		return filterSeasonValue;
	}

	public void setFilterSeasonValue(String filterSeasonValue) {
		this.filterSeasonValue = filterSeasonValue;
	}

	public Integer getFilterDurationStatus() {
		return filterDurationStatus;
	}

	public void setFilterDurationStatus(Integer filterDurationStatus) {
		this.filterDurationStatus = filterDurationStatus;
	}

	public String getFilterDurationValue() {
		return filterDurationValue;
	}

	public void setFilterDurationValue(String filterDurationValue) {
		this.filterDurationValue = filterDurationValue;
	}
}
