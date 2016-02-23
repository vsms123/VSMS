/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import Controller.UtilityController;

/**
 *
 * @author David
 */
public class Ingredient {
    private int supplier_id;
    private String name;
    private String supplyUnit;
    private String subcategory;
    private String description;
    private String offeredPrice;
    private String compo_id;
    
    public Ingredient(int supplier_id,String name,String supplyUnit,String subcategory,String description,String offeredPrice){
        this.supplier_id=supplier_id;
        this.name=name;
        this.supplyUnit=supplyUnit;
        this.subcategory=subcategory;
        this.description=description;
        this.offeredPrice=offeredPrice;
        this.compo_id = name + "|@|" + supplier_id;
    }

    public int getSupplier_id() {
        return supplier_id;
    }

    public void setSupplier_id(int supplier_id) {
        this.supplier_id = supplier_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSupplyUnit() {
        return supplyUnit;
    }

    public void setSupplyUnit(String supplyUnit) {
        this.supplyUnit = supplyUnit;
    }

    public String getSubcategory() {
        return subcategory;
    }

    public void setSubcategory(String subcategory) {
        this.subcategory = subcategory;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getOfferedPrice() {
        return offeredPrice;
    }

    public void setOfferedPrice(String offeredPrice) {
        this.offeredPrice = offeredPrice;
    }

    public String toString() {
        return "Ingredient{" + "supplier_id=" + supplier_id + ", name=" + name + ", supplyUnit=" + supplyUnit + ", subcategory=" + subcategory + ", description=" + description + ", offeredPrice=" + UtilityController.convertDoubleToCurrString(UtilityController.convertStringtoDouble(offeredPrice)) + '}';
    }
    
    public boolean equalCheck(Ingredient i){
        if(i.getName().equals(name) && i.getSupplier_id() == supplier_id){
            return true;
        }else{
            return false;
        }
    }
    
    public String getCompo_ID(){
        return compo_id;
    }
    
    public void setCompo_ID(String compo_id){
        this.compo_id = compo_id;
    }
    
    
    
         
}
