package com.umrah.entity;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "umrah_filter")
public class FilterEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "filter_id")
	private String filterId;
	
	@Column(name = "filter_start_price_status")
	private Integer filterStartPriceStatus;
	
	@Column(name = "filter_start_price_value")
	private Float filterStartPriceValue;
	
	@Column(name = "filter_end_price_status")
	private Integer filterEndPriceStatus;
	
	@Column(name = "filter_end_price_value")
	private Float filterEndPriceValue;
	
	@Column(name = "filter_season_status")
	private Integer filterSeasonStatus;
	
	@Column(name = "filter_season_value")
	private String filterSeasonValue;
	
	@Column(name = "filter_duration_status")
	private Integer filterDurationStatus;
	
	@Column(name = "filter_duration_value")
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
